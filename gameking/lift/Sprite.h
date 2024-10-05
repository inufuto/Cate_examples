#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Lift = 3;
constexpr byte SpriteCount = 9;

extern void ShowSprite(ptr<Movable> pMovable, byte c);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void DrawSprites();
extern void EraseSprites();