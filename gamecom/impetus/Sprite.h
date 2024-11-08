constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte SpriteCount_Fighter = 1;
constexpr byte SpriteCount_SkyEnemy = 3;
constexpr byte SpriteCount_GroundEnemy = 4;
constexpr byte SpriteCount_BarrierHead = 4;
constexpr byte SpriteCount_FighterBullet = 2;
constexpr byte SpriteCount_EnemyBullet = 4;
constexpr byte SpriteCount_Item = 1;
constexpr byte SpriteCount_Bang = 4;

constexpr byte Sprite_GroundEnemy = 0;
constexpr byte Sprite_BarrierHead = 4;
constexpr byte Sprite_Fighter = 8;
constexpr byte Sprite_SkyEnemy = 9;
constexpr byte Sprite_FighterBullet = 12;
constexpr byte Sprite_EnemyBullet = 14;
constexpr byte Sprite_Item = 18;
constexpr byte Sprite_Bang = 19;
constexpr byte Sprite_End = 23;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
extern void EraseSprites();
