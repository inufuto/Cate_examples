#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Lift = 3;
constexpr byte Sprite_Point = 9;
constexpr byte SpriteCount = 13;

struct Sprite {
    byte y, x, c;
};
extern Sprite[] Sprites;

extern void InitSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte c);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
