struct Barrier {
    byte y;
    byte left, right;
    byte sprite;
    byte length;
    byte oldY;
};

extern void InitBarriers();
extern void StartBarrier();
extern void MoveBarriers();
extern bool HitBulletBarrier(byte x, byte y);
extern bool HitFighterBarrier();
