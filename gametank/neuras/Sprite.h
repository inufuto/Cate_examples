constexpr byte Sprite_Solver = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Card = 5;
constexpr byte SpriteCount = 6;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
