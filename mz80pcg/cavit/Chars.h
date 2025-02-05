constexpr byte Char_Space = 0x0;

constexpr byte Char_Logo = 0x80;
constexpr byte Char_Soil = 0x88;
constexpr byte Char_Bedrock = 0x8A;
constexpr byte Char_Cent = 0x8B;
constexpr byte Char_Wall = 0x8C;
constexpr byte Char_Man = 0x94;
constexpr byte Char_Ghost = 0xD4;
constexpr byte Char_Rock = 0xF4;
constexpr byte Char_Chaser = 0xF8;
constexpr byte Char_Box = 0xFC;
constexpr byte Char_End = 0x100;

constexpr byte Char_Wall_Space = Char_Space;
constexpr byte Char_Wall_Left = Char_Wall + 0;
constexpr byte Char_Wall_Right = Char_Wall + 1;
constexpr byte Char_Wall_Top = Char_Wall + 2;
constexpr byte Char_Wall_Bottom = Char_Wall + 3;
constexpr byte Char_Wall_LeftTop = Char_Wall + 4;
constexpr byte Char_Wall_RightTop = Char_Wall + 5;
constexpr byte Char_Wall_LeftBottom = Char_Wall + 6;
constexpr byte Char_Wall_RightBottom = Char_Wall + 7;
