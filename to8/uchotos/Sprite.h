#include "Movable.h"

constexpr byte Sprite_Fire = 0;
constexpr byte Sprite_Monster = 2;
constexpr byte Sprite_Man = 6;
constexpr byte Sprite_Debri = 8;
constexpr byte Sprite_OneUp = 11;
constexpr byte Sprite_End = 12;

constexpr byte MonsterSpriteCount = 4;
constexpr byte FireSpriteCount = 2;
constexpr byte DebriSpriteCount = 3;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
