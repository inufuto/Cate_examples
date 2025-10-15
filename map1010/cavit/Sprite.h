#include "Movable.h"

constexpr byte StepMask = 7;

constexpr byte Sprite_Ghost = 0;
constexpr byte Sprite_Chaser = 2;
constexpr byte Sprite_Man = 6;
constexpr byte Sprite_Rock = 7;
constexpr byte Sprite_Point = 11;
constexpr byte SpriteCount = 15;


struct Sprite {
    byte x, y;
    byte code;
    byte oldX, oldY;
    byte oldCode;
};

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte code);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
