#include "Movable.h"

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Man = 4;
constexpr byte Sprite_Rock = 5;
constexpr byte Sprite_Ghost = 9;
constexpr byte Sprite_Chaser = 11;
constexpr byte Sprite_Box = 15;
constexpr byte SpriteCount = 20;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, byte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
