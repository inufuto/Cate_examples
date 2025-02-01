#include "Movable.h"

constexpr byte StepMask = 7;

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Block = 7;
constexpr byte Sprite_Point = 14;
constexpr byte SpriteCount = 18;

extern void HideAllSprites();
extern void ShowSpriteC(ptr<Movable> pMovable, byte code);
extern void ShowSpriteS(ptr<Movable> pMovable, ptr<byte> pCode);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
