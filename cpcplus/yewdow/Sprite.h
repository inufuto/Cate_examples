#include "Movable.h"

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Car = 2;
constexpr byte Sprite_Monster = 4;
constexpr byte Sprite_Man = 6;
constexpr byte Sprite_End = 7;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
