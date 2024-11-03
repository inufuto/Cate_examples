#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Monster_End = 5;
constexpr byte Sprite_Lift = 5;
constexpr byte Sprite_Lift_End = 9;
constexpr byte Sprite_Goal = 9;
constexpr byte Sprite_End = 13;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
