#include "Movable.h"

constexpr byte Sprite_Sky = 0;
constexpr byte Sprite_Bang = 0;
constexpr byte Sprite_FighterBullet = 4;
constexpr byte Sprite_EnemyBullet = 6;
constexpr byte Sprite_Fighter = 11;
constexpr byte Sprite_Item = 13;
constexpr byte Sprite_SkyEnemy = 14;
constexpr byte Sprite_Barrier = 22;
constexpr byte Sprite_Ground = 30;
constexpr byte Sprite_GroundEnemy = 30;
constexpr byte Sprite_End = 38;

constexpr byte MaxBangCount = 4;
constexpr byte MaxFighterBulletCount = 2;
constexpr byte MaxEnemyBulletCount = 5;
constexpr byte MaxSkyEnemyCount = 4;
constexpr byte MaxBarrierCount = 2;
constexpr byte MaxGroundEnemyCount = 4;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
extern void ShowSpriteXY(byte index, byte x, byte y, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
