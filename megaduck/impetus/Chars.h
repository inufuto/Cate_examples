
constexpr byte Char_Space = 0x0;
constexpr byte Char_Ascii = 0x0;
constexpr byte Char_Logo = 0x40;
constexpr byte Char_Barrier = 0x50;
constexpr byte Char_Color = 0x58;
constexpr byte Char_Remain = 0x58;
constexpr byte Char_End = 0x5C;
constexpr byte Char_Terrain = 0x5C;
constexpr byte Char_Fort = 0x94;


constexpr byte Pattern_Fighter = 0x0;
constexpr byte Pattern_SkyEnemy = 0x1;
constexpr byte Pattern_SkyEnemyA = 0x1;
constexpr byte Pattern_SkyEnemyB = 0x2;
constexpr byte Pattern_SkyEnemyC = 0xA;
constexpr byte Pattern_GroundEnemy = 0xB;
constexpr byte Pattern_GroundEnemyA = 0xB;
constexpr byte Pattern_GroundEnemyB = 0xC;
constexpr byte Pattern_FighterBullet = 0xD;
constexpr byte Pattern_EnemyBullet = 0xE;
constexpr byte Pattern_BarrierHead = 0xF;
constexpr byte Pattern_Bang = 0x10;
constexpr byte Pattern_SmallBang = 0x10;
constexpr byte Pattern_LargeBang = 0x11;
constexpr byte Pattern_Item = 0x15;
constexpr byte Pattern_End = 0x16;

constexpr byte TerrainCharCount = (Char_Fort - Char_Terrain) / 2;
