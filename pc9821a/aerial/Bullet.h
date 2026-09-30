#include "Movable.h"

constexpr byte HiVelocity = 50;
constexpr byte LoVelocity = HiVelocity * 70 / 100; // sin 45
constexpr byte LongVelocity = HiVelocity * 92 / 100; // cos 22.5
constexpr byte ShortVelocity = HiVelocity * 38 / 100; // sin 22.5

struct Bullet {
    Movable _;
    sbyte dx, dy;
    sbyte numeratorX, denominatorX;
    sbyte numeratorY, denominatorY;
};

extern void EndBullet(ptr<Bullet> pBullet);
extern void StartBullet(ptr<Bullet> pBullet, byte x, byte y);
extern bool MoveBullet(ptr<Bullet> pBullet);
// extern bool HitBulletMovable(ptr<Movable> pBullet, ptr<Movable> pMovable);
