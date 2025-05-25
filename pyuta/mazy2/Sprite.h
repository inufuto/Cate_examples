#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Knife = 7;
constexpr byte Sprite_Point = 11;
constexpr byte Sprite_End = 15;

extern void ShowSprite(word pMovable, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void PollVSync();
