#include "Movable.h"

constexpr byte StepMask = 7;

constexpr byte Sprite_Ghost = 0;
constexpr byte Sprite_Chaser = 2;
constexpr byte Sprite_Man = 6;
constexpr byte Sprite_Rock = 7;
constexpr byte Sprite_Point = 11;
constexpr byte Sprite_End = 15;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
