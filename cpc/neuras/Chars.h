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

constexpr word Char_Space = 0x0;
constexpr word Char_Ascii = 0x0;
constexpr word Char_Wall = 0x40;
constexpr word Char_Sprite = 0x50;
constexpr word Char_Solver = 0x50;
constexpr word Char_Monster = 0x70;
constexpr word Char_Card = 0x90;
constexpr word Char_Title = 0xC8;
constexpr word Char_End = 0xE0;
