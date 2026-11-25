#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte SpriteCount = 5;

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
