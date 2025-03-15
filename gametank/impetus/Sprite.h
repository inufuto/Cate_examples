#include "Vram.h"

constexpr byte MaxGroundEnemyCount = 4;
constexpr byte MaxBarrierHeadCount = 4;
constexpr byte MaxFighterCount = 1;
constexpr byte MaxSkyEnemyCount = 3;
constexpr byte MaxEnemyBulletCount = 4;
constexpr byte MaxFighterBulletCount = 2;
constexpr byte MaxBangCount = 4;
constexpr byte MaxItemCount = 1;

constexpr byte Sprite_GroundEnemy = 0;
constexpr byte Sprite_BarrierHead = 4;
constexpr byte Sprite_Fighter = 8;
constexpr byte Sprite_SkyEnemy = 9;
constexpr byte Sprite_EnemyBullet = 12;
constexpr byte Sprite_FighterBullet = 16;
constexpr byte Sprite_Bang = 18;
constexpr byte Sprite_Item = 22;
constexpr byte Sprite_End = 23;

constexpr byte CoordShift = 2;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

extern void HideAllSprites();
extern void ShowSprite(byte index, word x, byte y, byte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
