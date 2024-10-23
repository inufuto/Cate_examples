struct Barrier {
    byte y;
    byte left, right;
    byte sprite;
    byte length;
    byte oldY, newY;
};

extern bool BarrierChanged;

extern void InitBarriers();
extern void StartBarrier();
extern void DrawBarriers(word page);
extern void MoveBarriers();
extern bool HitBulletBarrier(byte x, byte y);
extern bool HitFighterBarrier();
