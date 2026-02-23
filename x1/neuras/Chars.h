constexpr byte Pattern_Solver_Left = 0;
constexpr byte Pattern_Solver_Right = Pattern_Solver_Left + 2;
constexpr byte Pattern_Solver_Up = Pattern_Solver_Right + 2;
constexpr byte Pattern_Solver_Down = Pattern_Solver_Up + 2;

constexpr byte Pattern_Monster_Left = Pattern_Solver_Down + 2;
constexpr byte Pattern_Monster_Right = Pattern_Monster_Left + 2;
constexpr byte Pattern_Monster_Up = Pattern_Monster_Right + 2;
constexpr byte Pattern_Monster_Down = Pattern_Monster_Up + 2;

constexpr byte Pattern_Card = Pattern_Monster_Down + 2;

constexpr byte Pattern_Title = Pattern_Card + 14;

constexpr byte Char_Space = 0x20;

constexpr byte Char_Wall = 0x60;
constexpr byte Char_Sprite = Char_Wall + 16;
constexpr byte Char_Title = Char_Sprite + 30 * 4;
constexpr byte Char_Ascii = Char_Title + 6 * 4;
