#include "Movable.h"

constexpr byte Sprite_Color = 0;
constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Block = 2;
constexpr byte Sprite_Mono = 10;
constexpr byte Sprite_Monster = 10;
constexpr byte Sprite_Point = 14;
constexpr byte Sprite_End = 18;

extern void ShowSpriteC(ptr<Movable> pMovable, byte pattern);
extern void ShowSpriteM(ptr<Movable> pMovable, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
