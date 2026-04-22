#include "Movable.h"

constexpr byte BallColor = 14;

struct Ball : Actor {
};

extern Ball[] Balls;

extern void InitBalls();
extern void MoveBalls();
extern bool IsBlockedByBall(ptr<Actor> pActor, byte column, byte row);