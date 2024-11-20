#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Monster_End = 5;
constexpr byte Sprite_Lift = 5;
constexpr byte Sprite_Lift_End = 9;
constexpr byte Sprite_End = 9;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars);
extern void HideSprite(byte index);
extern void DrawSprites();
extern void EraseSprites();
