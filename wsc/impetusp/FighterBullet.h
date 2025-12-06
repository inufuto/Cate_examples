#include "Movable.h"

struct FighterBullet : Movable {
    byte clock;
};

extern void InitFighterBullets();
extern void StartFighterBullet(bool on);
extern void MoveFighterBullets();
