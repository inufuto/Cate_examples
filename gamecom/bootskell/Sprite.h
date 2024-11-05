#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Block = 7;
constexpr byte Sprite_Point = 14;
constexpr byte SpriteCount = 18;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte c);
extern void HideSprite(byte index);
extern void DrawSprites();
extern void EraseSprites();