constexpr word Char_Space = 0x0;
constexpr word Char_Ascii = 0x0;
constexpr word Char_Logo = 0x40;
constexpr word Char_Wall = 0x50;
constexpr word Char_HardWall = 0x52;
constexpr word Char_Meter = 0x53;
constexpr word Char_Fence = 0x55;
constexpr word Char_MyFort = 0x57;
constexpr word Char_EnemyFort = 0x63;
constexpr word Char_End = 0x6F;

constexpr byte Pattern_MyRobo = 0;
constexpr byte Pattern_EnemyRobo = 8;
constexpr byte Pattern_Bullet = 16;
constexpr byte Pattern_SmallBang = 18;
constexpr byte Pattern_LargeBang = 19;
constexpr byte PatternCount = 23;

extern byte[] Chars, SpritePattern;
