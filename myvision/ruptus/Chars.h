constexpr byte Char_Barrier = 0x00;
constexpr byte Char_Fighter = 0x04;
constexpr byte Char_Map = 0x08;
constexpr byte Char_Logo = 0x10;
constexpr byte Char_Ascii = 0x20;
constexpr byte Char_Fort = 0x60;
constexpr byte Char_Star = 0xf0;

constexpr byte Pattern_Fighter = 0;
constexpr byte Pattern_Enemy = Pattern_Fighter + 8;
constexpr byte Pattern_FighterBullet = Pattern_Enemy + 8;
constexpr byte Pattern_EnemyBullet = Pattern_FighterBullet + 4;
constexpr byte Pattern_BarrierHead = Pattern_EnemyBullet + 1;
constexpr byte Pattern_Bang = Pattern_BarrierHead + 1;
constexpr byte Pattern_FighterOnMap = Pattern_Bang + 1 + 4;
constexpr byte Pattern_Item = Pattern_FighterOnMap + 1;
