#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Block = 5;
constexpr byte Sprite_Point = 9;
constexpr byte Sprite_End = 13;

extern void HideAllSprites();
extern void ShowSpriteC(ptr<Movable> pMovable, byte code);
extern void ShowSpriteS(ptr<Movable> pMovable, ptr<byte> pCodes);
extern void HideSprite(byte index);
extern void DrawSprites();
