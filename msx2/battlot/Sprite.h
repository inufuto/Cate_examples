constexpr byte Sprite_Color = 0;
constexpr byte Sprite_MyRobo = 0;
constexpr byte Sprite_EnemyRobo = 2;
constexpr byte Sprite_Bang = 10;
constexpr byte Sprite_Mono = 20;
constexpr byte Sprite_MyBullet = 20;
constexpr byte Sprite_EnemyBullet = 22;
constexpr byte Sprite_End = 28;

constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

extern void ShowSpriteC(byte index, byte x, byte y, byte pattern);
extern void ShowSpriteM(byte index, byte x, byte y, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
