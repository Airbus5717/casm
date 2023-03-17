const std = @import("std");

pub fn print(bytes: []const u8) void {
    std.io.getStdOut().writer().writeAll(bytes) catch {
        std.debug.panic("Stdout is not working", .{});
    };
}

pub fn readFile(name: []const u8, allocator: std.mem.Allocator) ![]const u8 {
    var path_buffer: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    const path = try std.fs.realpath(name, &path_buffer);

    // Open the file
    const file = try std.fs.openFileAbsolute(path, .{});
    defer file.close();

    // Read the contents
    const file_size = try file.getEndPos();
    const file_buffer = try file.readToEndAlloc(allocator, file_size);

    // Split by "\n" and iterate through the resulting slices of "const []u8"
    // var iter = std.mem.split(u8, file_buffer, "\n");

    // var count: usize = 0;
    // while (iter.next()) |line| : (count += 1) {
    //     std.log.info("{d:>2}: {s}", .{ count, line });
    // }
    return file_buffer;
}

const RESET = "\x1b[0m";
const BOLD = "\x1b[1m";
const FAINT = "\x1b[2m";
const GREEN = "\x1b[32m";
const YELLOW = "\x1b[33m";
const BLUE = "\x1b[34m";
const PINK = "\x1b[35m";
const CYAN = "\x1b[36m";
const BLACK = "\x1b[30m";
const WHITE = "\x1b[37m";
const DEFAULT = "\x1b[39m";
const LGRAY = "\x1b[90m";
const LRED = "\x1b[91m";
const LGREEN = "\x1b[92m";
const LYELLOW = "\x1b[93m";
const LBLUE = "\x1b[94m";
const LMAGENTA = "\x1b[95m";
const LCYAN = "\x1b[96m";
const LWHITE = "\x1b[97m";
