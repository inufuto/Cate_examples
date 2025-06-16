#include "Movable.h"

constexpr byte Sprite_Color = 0;
constexpr byte Sprite_Remain = 0;
constexpr byte Sprite_Man = 4;
constexpr byte Sprite_Mono = 6;
constexpr byte Sprite_Block = 6;
constexpr byte Sprite_Fire = 8;
constexpr byte Sprite_Monster = 12;
constexpr byte Sprite_End = 22;

extern void ShowSpriteC(ptr<Movable> pMovable, byte pattern);
extern void ShowSpriteCXY(byte index, byte x, byte y, byte pattern);
extern void ShowSpriteM(ptr<Movable> pMovable, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
