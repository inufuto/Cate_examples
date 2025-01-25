#include "Movable.h"

constexpr byte MaxPointCount = 4;
constexpr byte MaxFireCount = 4;

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Fire = 5;
constexpr byte Sprite_Point = 9;
constexpr byte Sprite_End = 13;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
