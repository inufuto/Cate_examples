constexpr byte CoordShift = 2;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Sprite_MyRobo = 0;
constexpr byte Sprite_EnemyRobo = 1;
constexpr byte Sprite_MyBullet = 5;
constexpr byte Sprite_EnemyBullet = 7;
constexpr byte Sprite_Bang = 13;
constexpr byte SpriteCount = 21;

extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void DrawSprites();
