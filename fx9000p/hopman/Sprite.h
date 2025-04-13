#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Monster_End = 6;
constexpr byte Sprite_Lift = 6;
constexpr byte Sprite_Lift_End = 10;
constexpr byte Sprite_End = 10;

extern void ShowSprite(ptr<Movable> pMovable, byte code);
extern void HideSprite(byte index);
extern void HideAllSprites();
// extern void UpdateSprites();
extern void DrawSprites();
