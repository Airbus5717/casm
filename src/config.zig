const std = @import("std");
const ComptimeStringMap = std.ComptimeStringMap;

pub const RInstr = enum(u8) {
    ADD = 0,
    SUB,
    SLT,
    SLTU,
    XOR,
    OR,
    AND,
    NOR,
    SLL,
    SRL,
    SRA,
    ROR,
};
pub const RInstrMap = ComptimeStringMap(RInstr, .{
    .{ "add", .ADD },
    .{ "sub", .SUB },
    .{ "slt", .SLT },
    .{ "sltu", .SLTU },
    .{ "xor", .XOR },
    .{ "or", .OR },
    .{ "and", .AND },
    .{ "nor", .NOR },
    .{ "sll", .SLL },
    .{ "srl", .SRL },
    .{ "sra", .SRA },
    .{ "ror", .ROR },
});

pub const IInstr = enum(u8) {
    ADDI = 0,
    SLTI,
    SLTIU,
    XORI,
    ORI,
    ANDI,
    NORI,
    SLLI,
    SRLI,
    SRAI,
    RORI,
};
pub const IInstrMap = ComptimeStringMap(IInstr, .{
    .{ "addi", .ADDI },
    .{ "slti", .SLTI },
    .{ "sltiu", .SLTIU },
    .{ "xori", .XORI },
    .{ "ori", .ORI },
    .{ "andi", .ANDI },
    .{ "nori", .NORI },
    .{ "slli", .SLLI },
    .{ "srli", .SRLI },
    .{ "srai", .SRAI },
    .{ "rori", .RORI },
});

pub const JInstr = enum(u8) {
    LUI,
    J,
    JAL,
};

pub const JInstrMap = ComptimeStringMap(JInstr, .{
    .{ "lui", .LUI },
    .{ "j", .J },
    .{ "jal", .JAL },
});

pub const RegsType = enum(u3) {
    R0 = 0,
    R1 = 1,
    R2 = 2,
    R3 = 3,
    R4 = 4,
    R5 = 5,
    R6 = 6,
    R7 = 7,
};

pub const RegistersMap = ComptimeStringMap(RegsType, .{
    .{ "r0", .R0 },
    .{ "r1", .R1 },
    .{ "r2", .R2 },
    .{ "r3", .R3 },
    .{ "r4", .R4 },
    .{ "r5", .R5 },
    .{ "r6", .R6 },
    .{ "r7", .R7 },
});
