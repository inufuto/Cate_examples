#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Block = 1;
constexpr byte Sprite_Fire = 8;
constexpr byte Sprite_Monster = 12;
constexpr byte SpriteCount = 21;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars);
extern void HideSprite(byte index);
extern void DrawSprites();
