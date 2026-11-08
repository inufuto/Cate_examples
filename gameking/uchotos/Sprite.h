#include "Movable.h"

constexpr byte Sprite_Fire = 0;
constexpr byte Sprite_Monster = 2;
constexpr byte Sprite_Man = 5;
constexpr byte Sprite_Debri = 7;
constexpr byte Sprite_OneUp = 10;
constexpr byte Sprite_End = 11;

constexpr byte MonsterSpriteCount = 3;
constexpr byte FireSpriteCount = 2;
constexpr byte DebriSpriteCount = 3;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void DrawSprites();
