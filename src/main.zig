//imports
const std = @import("std");
const common = @import("common.zig");

// import aliases
const print = common.print;
const readFile = common.readFile;
const assert = std.debug.assert;

fn assemble(name: [*:0]const u8, allocator: std.mem.Allocator) !void {
    // var path_buffer: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    // const path = try std.fs.realpath(std.mem.span(name), &path_buffer);
    // const dir = std.fs.path.dirname(path);
    // _ = dir;

    const asm_file = try readFile(std.mem.span(name), allocator);
    std.log.info("FILE READ", .{});
    print(asm_file);
}

pub fn assembleInit() void {
    var gp = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = {
        if (gp.deinit()) {
            std.log.err("There are memory leaks", .{});
        }
    };
    const allocator = gp.backing_allocator;

    var name: [*:0]const u8 = undefined;
    const s = std.process.argsAlloc(allocator) catch |e| {
        std.log.err("{}", .{e});
        return;
    };
    defer std.process.argsFree(allocator, s);
    if (s.len < 2) {
        name = "examples/code.asm";
    } else {
        name = s[1];
    }

    assemble(name, allocator) catch |e| {
        std.log.err("compile error {}", .{e});
    };
}

pub fn main() void {
    assembleInit();
}

test "tests" {
    _ = @import("common.zig");
}
