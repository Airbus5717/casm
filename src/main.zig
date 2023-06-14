//imports
const std = @import("std");
const utils = @import("utils.zig");
const parser = @import("parser.zig");

const print = utils.print;
const readFile = utils.readFile;
const assert = std.debug.assert;
const parse = parser.parse;

const string = utils.string;
const cstring = utils.cstring;

fn assemble(name: cstring, allocator: std.mem.Allocator) !void {
    // var path_buffer: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    // const path = try std.fs.realpath(std.mem.span(name), &path_buffer);
    // const dir = std.fs.path.dirname(path);
    // _ = dir;

    const asm_file = try readFile(std.mem.span(name), allocator);
    // std.log.info("FILE READ", .{});
    // print(asm_file);
    var tree: parser.SyntaxTree = .{};

    parse(&tree, asm_file, allocator) catch |e| {
        std.log.err("parsing err: {}", .{e});
    };

    defer {
        tree.labels.deinit();
        tree.instrs.deinit();
    }
}

pub fn assembleInit() void {
    // Init memory allocator
    var gp = std.heap.GeneralPurposeAllocator(.{
        .safety = true,
        .thread_safe = true,
    }){};

    defer _ = {
        if (gp.deinit()) {
            std.log.err("There are memory leaks", .{});
        }
    };
    const allocator = gp.backing_allocator;

    // allocate for command line arguments
    var name: cstring = undefined;
    const s = std.process.argsAlloc(allocator) catch |e| {
        std.log.err("{}", .{e});
        return;
    };
    defer std.process.argsFree(allocator, s);

    // default to examples file if no arguments passed
    if (s.len < 2) {
        name = "examples/code.asm";
    } else {
        name = s[1];
    }

    // Do the thing
    assemble(name, allocator) catch |e| {
        std.log.err("assemble problem {}", .{e});
    };
}

pub fn main() void {
    assembleInit();
}

test "tests" {
    _ = @import("utils.zig");
    _ = @import("structs.zig");
    _ = @import("parser.zig");
}
