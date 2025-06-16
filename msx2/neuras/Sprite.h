constexpr byte Sprite_Color = 0;
constexpr byte Sprite_Solver = 0;
constexpr byte Sprite_Mono = 2;
constexpr byte Sprite_Monster = 2;
constexpr byte Sprite_Card = 6;
constexpr byte Sprite_End = 7;

extern void ShowSpriteC(byte index, byte x, byte y, byte pattern);
extern void ShowSpriteM(byte index, byte x, byte y, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
