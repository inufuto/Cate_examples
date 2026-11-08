#include "Movable.h"

constexpr byte Sprite_Ball = 0;
constexpr byte Sprite_Monster = 4;
constexpr byte Sprite_Man = 8;
constexpr byte Sprite_OneUp = 10;
constexpr byte Sprite_End = 11;

constexpr byte BallSpriteCount = 4;
constexpr byte MonsterSpriteCount = 4;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void DrawSprites();
