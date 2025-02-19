constexpr byte CoordShift = 1;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_SkyEnemy = 1;
constexpr byte Sprite_GroundEnemy = 4;
constexpr byte Sprite_BarrierHead = 8;
constexpr byte Sprite_FighterBullet = 12;
constexpr byte Sprite_EnemyBullet = 14;
constexpr byte Sprite_Item = 18;
constexpr byte Sprite_Bang = 19;
constexpr byte SpriteCount = 23;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
