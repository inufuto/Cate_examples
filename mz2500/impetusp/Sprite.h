#include "Movable.h"

constexpr byte Sprite_Sky = 0;
constexpr byte Sprite_Bang = 0;
constexpr byte Sprite_FighterBullet = 6;
constexpr byte Sprite_EnemyBullet = 8;
constexpr byte Sprite_Fighter = 13;
constexpr byte Sprite_Item = 14;
constexpr byte Sprite_SkyEnemy = 15;
constexpr byte Sprite_Barrier = 19;
constexpr byte Sprite_Ground = 25;
constexpr byte Sprite_GroundEnemy = 25;
constexpr byte Sprite_End = 29;

constexpr byte MaxBangCount = 6;
constexpr byte MaxFighterBulletCount = 2;
constexpr byte MaxEnemyBulletCount = 5;
constexpr byte MaxSkyEnemyCount = 4;
constexpr byte MaxBarrierCount = 2;
constexpr byte MaxGroundEnemyCount = 4;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void ShowSpriteXY(byte index, byte x, byte y, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
extern void UpdateSprites();
