#include "Movable.h"

constexpr byte MaxFireCount = 4;

constexpr byte Sprite_Fire = 0;
constexpr byte Sprite_Monster = 4;
constexpr byte Sprite_Man = 8;
constexpr byte Sprite_End = 9;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void DrawSprites();
