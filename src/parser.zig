const std = @import("std");
const structs = @import("structs.zig");
const Instr = structs.Instr;
const utils = @import("utils.zig");
const Token = structs.Token;
const string = utils.string;
const isDigit = std.ascii.isDigit;
const labelMap = std.StringHashMap(usize);
const Array = std.ArrayList;
const NOP = Token{ .type = .ERR_UNKNOWN };

pub const SyntaxTree = struct {
    labels: labelMap = undefined,
    instrs: Array(Instr) = undefined,
    idx: usize = 0,
};

pub fn parse(
    tree: *SyntaxTree,
    file: string,
    allocator: std.mem.Allocator,
) !void {
    tree.labels = labelMap.init(allocator);
    tree.instrs = try std.ArrayList(Instr).initCapacity(allocator, 10);
    // Split by "\n" and iterate through the resulting slices of "const []u8"
    var iter = std.mem.split(u8, file, "\n");

    var count: usize = 0;
    while (iter.next()) |line| : (count += 1) {
        // std.log.info("{d:>2}: {s}", .{ count, line });
        tree.idx = 0;
        parseLine(tree, line) catch {
            std.log.err("{i} | {s}", .{ count + 1, line });
            std.log.info("{Error here}");
        };
    }
}

fn parseLine(tree: *SyntaxTree, line: string) !void {
    const tkn = getNextToken(tree, line);
    switch (tkn.type) {
        .R_INSTR => {},
        .I_INSTR => {},
        .J_INSTR => {},
        .ID_LIT => {},
        else => {},
    }
    try tree.instrs.append();
}

fn parseIinstr(line: string) structs.IInstr {
    _ = line;
}
fn parseJinstr(line: string) structs.JInstr {
    _ = line;
}
fn parseRinstr(line: string) structs.RInstr {
    _ = line;
}

fn getNextToken(tree: *SyntaxTree, line: string) Token {
    const trimmedLine: string = skipWhitespace(line);
    return switch (trimmedLine[0]) {
        '0'...'9' => parseNumerics(tree, trimmedLine),
        'a'...'z', 'A'...'Z', '_' => parseKeyword(tree, line),
        ',' => (Token{ .type = .COMMA }),
        else => NOP,
    };
}

fn skipWhitespace(line: string) string {
    var count: u32 = 0;
    for (line) |chr| {
        if (!std.ascii.isWhitespace(chr)) {
            break;
        }
        count += 1;
    }
    return line[count..];
}

fn parseNumerics(tree: *SyntaxTree, sc_line: string) Token {
    var count: usize = 0;
    for (sc_line, 0..) |c, i| {
        if (!isDigit(c)) {
            count = i;
            break;
        }
    }
    tree.idx += count;
    return Token{ .type = .INT_LIT };
}
fn parseKeyword(tree: *SyntaxTree, sc_line: string) Token {
    _ = tree;
    var count = 0;
    for (sc_line, 0..) |c, i| {
        count = i;
        if (std.ascii.isAlphanumeric(c) or c == '_') {
            continue;
        } else break;
    }

    var tkn_type: structs.TknType = .ID_LIT;
    if (structs.IInstrMap.has(sc_line[0 .. count + 1])) {
        type = .I_INSTR;
    } else if (structs.RInstrMap.has(sc_line[0 .. count + 1])) {
        type = .R_INSTR;
    } else if (structs.JInstrMap.has(sc_line[0 .. count + 1])) {
        type = .J_INSTR;
    }
    return Token{ .type = tkn_type };
}
