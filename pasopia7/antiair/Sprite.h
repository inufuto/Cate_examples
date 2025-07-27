#include "Movable.h"

// constexpr byte StepMask = 7;

constexpr byte Sprite_MyFighter = 0;
constexpr byte Sprite_EnemyFighter = 1;
constexpr byte Sprite_GroundEnemy = 5;
constexpr byte Sprite_MyBullet = 11;
constexpr byte Sprite_EnemyBullet = 14;
constexpr byte Sprite_Bang = 18;
constexpr byte Sprite_Item = 24;
constexpr byte SpriteCount = 25;


struct Sprite {
    byte x, y;
    byte code;
    byte oldX, oldY;
    byte oldCode;
};

extern void InitSprites();
extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte code);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
