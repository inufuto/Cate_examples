#include "Movable.h"

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Ball = 4;
constexpr byte Sprite_Monster = 8;
constexpr byte Sprite_Man = 12;
constexpr byte Sprite_OneUp = 14;
constexpr byte Sprite_End = 15;

constexpr byte PointSpriteCount = 4;
constexpr byte BallSpriteCount = 4;
constexpr byte MonsterSpriteCount = 4;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void ShowSpriteS(ptr<Movable> pMovable, ptr<byte> pChars);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void DrawSprites();
