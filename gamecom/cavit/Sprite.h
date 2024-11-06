#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Ghost = 1;
constexpr byte Sprite_Chaser = 5;
constexpr byte Sprite_Rock = 9;
constexpr byte Sprite_Point = 13;
constexpr byte SpriteCount = 17;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
extern void EraseSprites();
