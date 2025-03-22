#include "Vram.h"

constexpr byte MaxFighterCount = 1;
constexpr byte MaxFighterBulletCount = 2;
constexpr byte MaxSkyEnemyCount = 3;
constexpr byte MaxEnemyBulletCount = 4;
constexpr byte MaxBarrierElementCount = 12;
constexpr byte MaxItemCount = 1;
constexpr byte MaxBangCount = 4;
constexpr byte MaxFortElementCount = 9;
constexpr byte MaxGroundEnemyCount = 4;

constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_FighterBullet = 1;
constexpr byte Sprite_SkyEnemy = 3;
constexpr byte Sprite_EnemyBullet = 6;
constexpr byte Sprite_BarrierElement = 10;
constexpr byte Sprite_Item = 22;
constexpr byte Sprite_Bang = 23;
constexpr byte Sprite_FortElement = 27;
constexpr byte Sprite_GroundEnemy = 36;
constexpr byte Sprite_End = 40;

constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, byte pattern);
extern void HideSprite(byte index);
extern void UpdateSprites();