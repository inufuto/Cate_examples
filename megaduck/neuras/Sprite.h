constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Sprite_Solver = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Card = 5;
constexpr byte SpriteCount = 6;

extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
