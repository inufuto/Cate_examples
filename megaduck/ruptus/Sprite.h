constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;


constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_MapPoint = 1;
constexpr byte Sprite_Item = 2;
constexpr byte Sprite_Enemy = 3;
constexpr byte Sprite_Barrier = 6;
constexpr byte Sprite_FighterBullet = 12;
constexpr byte Sprite_EnemyBullet = 16;
constexpr byte Sprite_Bang = 20;
constexpr byte Sprite_End = 28;

extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
