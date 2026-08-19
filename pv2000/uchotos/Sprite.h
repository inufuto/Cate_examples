#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 2;
constexpr byte Sprite_Fire = 6;
constexpr byte Sprite_Debri = 8;
constexpr byte Sprite_OneUp = 11;
constexpr byte Sprite_End = 12;

constexpr byte MonsterSpriteCount = 4;
constexpr byte FireSpriteCount = 2;
constexpr byte DebriSpriteCount = 3;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
