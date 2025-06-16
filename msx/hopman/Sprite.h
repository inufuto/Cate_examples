#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Monster_End = 5;
constexpr byte Sprite_Lift = 5;
constexpr byte Sprite_Lift_End = 9;
constexpr byte Sprite_Goal = 9;
constexpr byte Sprite_End = 13;

struct Sprite {
    byte y, x, name, color;
};
extern Sprite[] Sprites;

extern void InitSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
