#include "Movable.h"

constexpr byte StepMask = 7;

constexpr byte Sprite_Item = 0;
constexpr byte Sprite_Man = 8;
constexpr byte Sprite_Monster = 9;
constexpr byte Sprite_Lift = 11;
constexpr byte SpriteCount = 17;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars);
extern void HideSprite(byte index);
extern void DrawSprites();
