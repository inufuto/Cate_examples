#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Ghost = 1;
constexpr byte Sprite_Chaser = 3;
constexpr byte Sprite_Rock = 7;
constexpr byte Sprite_Point = 11;
constexpr byte SpriteCount = 15;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, byte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
