#include "Movable.h"

constexpr byte Sprite_Cannon = 0;
constexpr byte Sprite_Bullet = 1;
constexpr byte Sprite_FallingBlock = 3;
constexpr byte Sprite_Bang = 11;
constexpr byte Sprite_End = 23;

constexpr byte MaxCannonCount = 1;
constexpr byte MaxBulletCount = 2;
constexpr byte MaxFallingBlockCount = 8;
constexpr byte MaxBangCount = 12;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
