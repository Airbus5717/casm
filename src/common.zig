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

pub const RESET = "\x1b[0m";
pub const BOLD = "\x1b[1m";
pub const FAINT = "\x1b[2m";
pub const GREEN = "\x1b[32m";
pub const YELLOW = "\x1b[33m";
pub const BLUE = "\x1b[34m";
pub const PINK = "\x1b[35m";
pub const CYAN = "\x1b[36m";
pub const BLACK = "\x1b[30m";
pub const WHITE = "\x1b[37m";
pub const DEFAULT = "\x1b[39m";
pub const LGRAY = "\x1b[90m";
pub const LRED = "\x1b[91m";
pub const LGREEN = "\x1b[92m";
pub const LYELLOW = "\x1b[93m";
pub const LBLUE = "\x1b[94m";
pub const LMAGENTA = "\x1b[95m";
pub const LCYAN = "\x1b[96m";
pub const LWHITE = "\x1b[97m";

pub const string = []const u8;
pub const cstring = [*:0]const u8;
