#include "Movable.h"

constexpr byte Sprite_Background = 0x0;
constexpr byte Sprite_Background_End = 0x28;
constexpr byte Sprite_Man = 0x28;
constexpr byte Sprite_Monster = 0x29;
constexpr byte Sprite_Knife = 0x2E;
constexpr byte Sprite_Point = 0x32;
constexpr byte Sprite_Logo = 0x36;
constexpr byte Sprite_Chars = 0x4A;
constexpr byte Sprite_Score = 0x4A;
constexpr byte Sprite_Stage = 0x4D;
constexpr byte Sprite_Time = 0x50;
constexpr byte Sprite_HeldKnives = 0x52;
constexpr byte Sprite_Remain = 0x54;
constexpr byte Sprite_Mini = 0x56;
constexpr byte Sprite_Message1 = 0x58;
constexpr byte Sprite_Message2 = 0x62;
constexpr byte Sprite_End = 0x68;

constexpr byte MaxPointCount = 4;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
extern void ShowSpriteXY(byte index, byte x, byte y, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
