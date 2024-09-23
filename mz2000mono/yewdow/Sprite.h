#include "Movable.h"

constexpr byte Sprite_Car = 0;
constexpr byte Sprite_Man = 2;
constexpr byte Sprite_Monster = 3;
constexpr byte Sprite_Point = 5;
constexpr byte Sprite_End = 7;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte code);
extern void HideSprite(byte index);
extern void DrawSprites();