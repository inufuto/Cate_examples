#include "Movable.h"

constexpr byte Sprite_Sky = 0;
constexpr byte Sprite_Bang = 0;
constexpr byte Sprite_FighterBullet = 4;
constexpr byte Sprite_EnemyBullet = 6;
constexpr byte Sprite_Fighter = 11;
constexpr byte Sprite_Item = 12;
constexpr byte Sprite_SkyEnemy = 13;
constexpr byte Sprite_Barrier = 17;
constexpr byte Sprite_Ground = 23;
constexpr byte Sprite_GroundEnemy = 23;
constexpr byte Sprite_End = 27;

constexpr byte MaxBangCount = 4;
constexpr byte MaxFighterBulletCount = 2;
constexpr byte MaxEnemyBulletCount = 5;
constexpr byte MaxSkyEnemyCount = 4;
constexpr byte MaxBarrierCount = 2;
constexpr byte MaxGroundEnemyCount = 4;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void ShowSpriteXY(byte index, byte x, byte y, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
