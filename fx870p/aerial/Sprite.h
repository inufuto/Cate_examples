#include "Movable.h"

constexpr byte Sprite_MyFighter = 0;
constexpr byte Sprite_EnemyFighter = 1;
constexpr byte Sprite_GroundEnemy = 5;
constexpr byte Sprite_MyBullet = 11;
constexpr byte Sprite_EnemyBullet = 14;
constexpr byte Sprite_Bang = 18;
constexpr byte Sprite_Item = 24;
constexpr byte SpriteCount = 25;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
