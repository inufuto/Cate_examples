struct Barrier {
    byte y;
    byte left, right, center;
    byte sprite;
    byte length;
};

extern void InitBarriers();
extern void StartBarrier();
extern void MoveBarriers();
extern bool HitBulletBarrier(byte x, byte y);
extern bool HitFighterBarrier();
