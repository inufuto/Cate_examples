#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Block = 5;
constexpr byte Sprite_End = 9;

constexpr byte MonsterSpriteCount = 4;
constexpr byte BlockSpriteCount = 4;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
