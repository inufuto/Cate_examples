#include "Movable.h"

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Bang = 4;
constexpr byte Sprite_Monster = 6;
constexpr byte Sprite_Man = 10;
constexpr byte Sprite_End = 11;

constexpr byte MaxPointCount = 4;
constexpr byte MaxBangCount = 2;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
