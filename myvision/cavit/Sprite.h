#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Ghost = 1;
constexpr byte Sprite_Chaser = 5;
constexpr byte Sprite_Rock = 9;
constexpr byte Sprite_Point = 13;
constexpr byte SpriteCount = 17;

constexpr byte Pattern_Man = 0;
constexpr byte Pattern_Ghost = 64;
constexpr byte Pattern_Chaser = 96;
constexpr byte Pattern_Rock = 100;
constexpr byte Pattern_Point = 104;
constexpr byte Pattern_Loose = 120;
constexpr byte PatternCount = 128;

struct Sprite {
    byte y, x, name, color;
};
extern Sprite[] Sprites;

extern void InitSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
