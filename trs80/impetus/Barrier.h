struct Barrier {
    byte y;
    byte left, right;
    byte length;
};

extern void InitBarriers();
extern void StartBarrier();
extern void DrawBarriers();
extern void MoveBarriers();
extern bool HitBulletBarrier(byte x, byte y);
extern bool HitFighterBarrier();
