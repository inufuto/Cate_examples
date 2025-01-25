#include "Movable.h"

constexpr byte MaxPointCount = 4;
constexpr byte MaxFireCount = 4;

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Fire = 4;
constexpr byte Sprite_Monster = 8;
constexpr byte Sprite_Man = 12;
constexpr byte Sprite_End = 13;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void DrawSprites();
