#include "Movable.h"

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Man = 4;
constexpr byte Sprite_Monster = 5;
constexpr byte Sprite_Lift = 7;
constexpr byte SpriteCount = 13;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte sprite);
extern void DrawSprites();
