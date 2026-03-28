#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Block = 7;
constexpr byte Sprite_Point = 14;
constexpr byte SpriteCount = 18;

constexpr byte Pattern_Man = 0;
constexpr byte Pattern_Monster = 48;
constexpr byte Pattern_Block = 96;
constexpr byte Pattern_Point = 100;
constexpr byte PatternCount = 116;

struct Sprite {
    byte y, x, name, color;
};
extern Sprite[] Sprites;

extern void InitSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
