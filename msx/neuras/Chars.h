constexpr byte Pattern_Solver_Left = 0;
constexpr byte Pattern_Solver_Right = Pattern_Solver_Left + 2;
constexpr byte Pattern_Solver_Up = Pattern_Solver_Right + 2;
constexpr byte Pattern_Solver_Down = Pattern_Solver_Up + 2;

constexpr byte Pattern_Monster_Left = Pattern_Solver_Down + 2;
constexpr byte Pattern_Monster_Right = Pattern_Monster_Left + 2;
constexpr byte Pattern_Monster_Up = Pattern_Monster_Right + 2;
constexpr byte Pattern_Monster_Down = Pattern_Monster_Up + 2;

constexpr byte Pattern_Card = Pattern_Monster_Down + 2;

constexpr byte Char_Wall = 0x80;
constexpr byte Char_Pattern = Char_Wall + 16;
constexpr byte Char_Title = Char_Pattern + 4*16;
constexpr byte Char_End = Char_Title + 4*6;

constexpr byte Char_Solver = Char_Pattern;
constexpr byte Char_Monster = Char_Solver + 4;
constexpr byte Char_Card = Char_Monster + 4;
