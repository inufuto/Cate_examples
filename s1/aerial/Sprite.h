#include "Movable.h"

constexpr byte Sprite_MyFighter = 0;
constexpr byte Sprite_EnemyFighter = 1;
constexpr byte Sprite_GroundEnemy = 5;
constexpr byte Sprite_MyBullet = 9;
constexpr byte Sprite_EnemyBullet = 12;
constexpr byte Sprite_Bang = 16;
constexpr byte Sprite_Item = 22;
constexpr byte SpriteCount = 23;

extern void InitSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte sprite);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
