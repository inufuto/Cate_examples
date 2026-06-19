#include "Movable.h"

constexpr byte StepMask = 7;

constexpr byte Sprite_Item = 0;
constexpr byte Sprite_Man = 8;
constexpr byte Sprite_Monster = 9;
constexpr byte Sprite_Lift = 11;
constexpr byte Sprite_Point = 17;
constexpr byte SpriteCount = 21;


struct Sprite {
    byte x, y;
    byte code;
};

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte code);
extern void HideSprite(byte index);
// extern void EraseSprites();
extern void DrawSprites();
