#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte SpriteCount = 5;

struct Sprite {
    byte y, x, name, color;
};
extern Sprite[] Sprites;

extern void InitSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
