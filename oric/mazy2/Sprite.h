#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Knife = 7;
constexpr byte Sprite_Point = 11;
constexpr byte Sprite_End = 15;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
