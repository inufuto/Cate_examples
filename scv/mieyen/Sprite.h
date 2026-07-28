#include "Movable.h"

constexpr byte Sprite_Background = 0x0;
constexpr byte Sprite_Background_End = 0x28;
constexpr byte Sprite_Man = 0x28;
constexpr byte Sprite_Monster = 0x29;
constexpr byte Sprite_Fire = 0x2D;
constexpr byte Sprite_Point = 0x31;
constexpr byte Sprite_Logo = 0x35;
constexpr byte Sprite_Chars = 0x49;
constexpr byte Sprite_Score = 0x49;
constexpr byte Sprite_Stage = 0x4C;
constexpr byte Sprite_Food = 0x4F;
constexpr byte Sprite_FoodCount = 0x50;
constexpr byte Sprite_Remain = 0x51;
constexpr byte Sprite_Mini = 0x53;
constexpr byte Sprite_Message1 = 0x55;
constexpr byte Sprite_Message2 = 0x5F;
constexpr byte Sprite_End = 0x65;

constexpr byte MaxFireCount = 4;
constexpr byte MaxPointCount = 4;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
extern void ShowSpriteXY(byte index, byte x, byte y, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
