#include "Movable.h"

constexpr byte Sprite_Fort = 0;
constexpr byte Sprite_MyFighter = 6;
constexpr byte Sprite_EnemyFighter = 7;
constexpr byte Sprite_GroundEnemy = 11;
constexpr byte Sprite_MyBullet = 17;
constexpr byte Sprite_EnemyBullet = 20;
constexpr byte Sprite_Bang = 24;
constexpr byte Sprite_Item = 30;
constexpr byte SpriteCount = 31;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void DrawSprites();
