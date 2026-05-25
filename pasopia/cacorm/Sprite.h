#include "Movable.h"

constexpr byte StepMask = 7;

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Point = 5;
constexpr byte Sprite_Increaser = 13;
constexpr byte SpriteCount = 14;


struct Sprite {
    byte x, y;
    byte code;
};

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte code);
extern void HideSprite(byte index);
extern void DrawSprites();
