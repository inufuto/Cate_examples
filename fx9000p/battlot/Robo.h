#include "Bullet.h"

constexpr byte Robo_Direction_Mask = 0x06;
constexpr byte Robo_Seq_Mask = 0x01;
constexpr byte Robo_Pattern_Mask = 0x07;
constexpr byte Robo_Status_Mask = 0x30;
constexpr byte Robo_Status_None = 0x00;
constexpr byte Robo_Status_Live = 0x10;
constexpr byte Robo_Status_Wait = 0x20;
constexpr byte Robo_CanMove_Mask = 0x40;
constexpr byte Robo_Target_Mask = 0x80;

constexpr byte RoboSize = 2;


struct Robo {
    byte x, y;
    sbyte dx, dy;
    byte step;
    byte sprite;
    byte status;
    byte count;
};

extern byte RoboStartIndex;

extern bool StartRobo(ptr<Robo> pRobo, byte fortX, byte fortY);
extern byte WallAroundRobo(ptr<Robo> pRobo, byte x, byte y);
extern byte TestMoveRobo(ptr<Robo> pRobo, byte direction);
extern void SetRoboDirection(ptr<Robo> pRobo, byte direction);
extern bool MoveRobo(ptr<Robo> pRobo);
extern bool Fire(ptr<Robo> pRobo, bool my);
extern bool HitRoboR(ptr<Robo> pRobo, byte x, byte y);
extern bool HitRoboB(ptr<Robo> pRobo, ptr<Bullet> pBullet);

extern Robo MyRobo;
extern void StartMyRobo(byte status);
extern void MoveMyRobo();
extern bool HitMyRoboR(ptr<Robo> pRobo, byte x, byte y);
extern bool HitMyRoboB(ptr<Bullet> pBullet);

extern Robo[] EnemyRobos;
extern byte HitEnemyRoboSprite;
extern void InitEnemyRobos();
extern bool StartEnemyRobo();
extern void MoveEnemyRobos();
extern bool HitEnemyRoboR(ptr<Robo> p, byte x, byte y);
extern bool HitEnemyRoboB(ptr<Bullet> pBullet);
