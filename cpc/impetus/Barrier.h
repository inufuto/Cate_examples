struct Barrier {
    byte y;
    byte left, right;
    byte length;
    byte oldY;
};

extern void InitBarriers();
extern void StartBarrier();
extern void DrawBarriers();
extern void EraseBarriers();
extern void MoveBarriers();
extern bool HitBulletBarrier(byte x, byte y);
extern bool HitFighterBarrier();
