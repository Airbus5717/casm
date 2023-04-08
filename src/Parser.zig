const std = @import("std");
const structs = @import("structs.zig");
const Instr = structs.Instr;
const common = @import("common.zig");
const Token = structs.Token;
const string = common.string;

const labelMap = std.StringHashMap(usize);
const Array = std.ArrayList;

const Lexer = @This();

pub const SyntaxTree = struct {
    labels: labelMap = undefined,
    instrs: Array(Instr) = undefined,
};

pub fn parse(
    file: string,
    tree: *SyntaxTree,
    allocator: std.mem.Allocator,
) !void {
    tree.labels = labelMap.init(allocator);
    tree.instrs = try std.ArrayList(Instr).initCapacity(allocator, 10);
    // Split by "\n" and iterate through the resulting slices of "const []u8"
    var iter = std.mem.split(u8, file, "\n");

    var count: usize = 0;
    while (iter.next()) |line| : (count += 1) {
        // std.log.info("{d:>2}: {s}", .{ count, line });
        try tree.instrs.append(parseLine(line));
    }
}

fn parseLine(line: string) Instr {
    _ = line;
    return .{};
}

fn getNextToken(line: string, idx: u32) Token {
    _ = idx;
    _ = line;
}
