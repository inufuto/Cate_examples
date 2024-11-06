constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_Item = 1;
constexpr byte Sprite_Enemy = 2;
constexpr byte Sprite_Barrier = 5;
constexpr byte Sprite_FighterBullet = 11;
constexpr byte Sprite_EnemyBullet = 15;
constexpr byte Sprite_Bang = 19;
constexpr byte Sprite_End = 27;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
extern void EraseSprites();
