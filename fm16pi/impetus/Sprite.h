
constexpr byte Sprite_Bang = 0;
constexpr byte Sprite_Fighter = 4;
constexpr byte Sprite_FighterBullet = 5;
constexpr byte Sprite_SkyEnemy = 7;
constexpr byte Sprite_EnemyBullet = 10;
constexpr byte Sprite_BarrierHead = 14;
constexpr byte Sprite_Item = 18;
constexpr byte Sprite_GroundEnemy = 19;
constexpr byte Sprite_End = 23;

constexpr byte BangCount = 4;
constexpr byte FighterCount = 1;
constexpr byte FighterBulletCount = 2;
constexpr byte SkyEnemyCount = 3;
constexpr byte EnemyBulletCount = 4;
constexpr byte BarrierHeadCount = 4;
constexpr byte ItemCount = 1;
constexpr byte GroundEnemyCount = 4;

constexpr byte CoordShift = 2;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
