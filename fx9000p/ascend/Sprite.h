#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Block = 1;
constexpr byte Sprite_Fire = 8;
constexpr byte Sprite_Monster = 12;
constexpr byte SpriteCount = 21;

struct Sprite {
    byte x, y;
    byte code;
};

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte code);
extern void HideSprite(byte index);
extern void DrawSprites();
