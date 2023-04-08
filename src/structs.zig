pub const Instr = union(InstrKind) {
    r: RInstrRepr,
    i: IInstrRepr,
    j: JInstrRepr,
};

pub const InstrKind = enum(u8) {
    r,
    i,
    j,
};

pub const RInstrRepr = packed struct(u16) {
    fn_code: u2,
    rd: u3,
    rt: u3,
    rs: u3,
    op: u5,
};

pub const IInstrRepr = packed struct(u16) {
    imm: u5,
    rt: u3,
    rs: u3,
    op: u5,
};

pub const JInstrRepr = packed struct(u16) {
    imm: u11,
    op: u5,
};

pub const Token = struct {
    _type: TknType,
    idx: u32,
    line: u32,
};

pub const TknType = enum(u8) {
    EOF, // END OF FILE (FOR PARSING ONLY)
    REG, // r0
    R_INSTR, // add
    I_INSTR, // addi
    J_INSTR, // j
    ID_LIT, // label
    INT_LIT, // 123
    HEX_LIT, // 0xab
    CHR_LIT, // '\n'

    COMMA, // OPTIONAL: ,
};
