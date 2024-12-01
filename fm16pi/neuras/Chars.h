constexpr word Char_Space = 0x0;
constexpr word Char_Ascii = 0x0;
constexpr word Char_Wall = 0x40;
constexpr word Char_Solver = 0x50;
constexpr word Char_Monster = 0x54;
constexpr word Char_Card = 0x58;
constexpr word Char_N = 0x90;
constexpr word Char_E = 0x94;
constexpr word Char_U = 0x98;
constexpr word Char_R = 0x9C;
constexpr word Char_A = 0xA0;
constexpr word Char_S = 0xA4;
constexpr word Char_End = 0xA8;

constexpr byte Pattern_Solver = 0;
constexpr byte Pattern_Monster = 8;
constexpr byte Pattern_Card = 16;
constexpr byte PatternCount = 17;


constexpr byte Pattern_Solver_Left = Pattern_Solver;
constexpr byte Pattern_Solver_Right = Pattern_Solver_Left + 2;
constexpr byte Pattern_Solver_Up = Pattern_Solver_Right + 2;
constexpr byte Pattern_Solver_Down = Pattern_Solver_Up + 2;

constexpr byte Pattern_Monster_Left = Pattern_Monster;
constexpr byte Pattern_Monster_Right = Pattern_Monster_Left + 2;
constexpr byte Pattern_Monster_Up = Pattern_Monster_Right + 2;
constexpr byte Pattern_Monster_Down = Pattern_Monster_Up + 2;
