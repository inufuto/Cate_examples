#include "Movable.h"

constexpr byte StepMask = 7;

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Increaser = 5;
constexpr byte SpriteCount = 6;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars);
extern void HideSprite(byte index);
extern void DrawSprites();
