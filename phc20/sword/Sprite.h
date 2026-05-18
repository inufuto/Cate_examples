#include "Movable.h"

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Ball = 8;
constexpr byte Sprite_Monster = 12;
constexpr byte Sprite_Man = 16;
constexpr byte Sprite_OneUp = 18;
constexpr byte Sprite_End = 19;

constexpr byte PointSpriteCount = 4;
constexpr byte BallSpriteCount = 4;
constexpr byte MonsterSpriteCount = 4;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void DrawSprites();
