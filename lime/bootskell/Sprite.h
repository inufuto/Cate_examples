#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Block = 7;
constexpr byte Sprite_Point = 14;
constexpr byte SpriteCount = 18;

struct Sprite {
    byte x, y, pattern;
    byte oldX, oldY, oldPattern;
};
extern Sprite[] Sprites;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte sprite);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
