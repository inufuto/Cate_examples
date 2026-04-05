#include "Movable.h"

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Bang = 8;
constexpr byte Sprite_Monster = 10;
constexpr byte Sprite_Man = 14;
constexpr byte Sprite_End = 15;

constexpr byte MaxPointCount = 8;
constexpr byte MaxBangCount = 2;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void DrawSprites();
