#include "Movable.h"

constexpr byte StepMask = 7;

constexpr byte Sprite_Box = 0;
constexpr byte Sprite_Ghost = 5;
constexpr byte Sprite_Chaser = 7;
constexpr byte Sprite_Man = 11;
constexpr byte Sprite_Rock = 12;
constexpr byte Sprite_Point = 16;
constexpr byte SpriteCount = 20;


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
