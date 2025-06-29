struct Fort {
    byte x, y;
    byte targetX;
    byte life;
    byte clock;
    byte oldX, oldY;
};

extern Fort[] Forts;
extern byte FortCount;

extern void InitForts();
extern void DrawForts();
// extern void EraseForts();
extern void StartForts();
extern bool HitBulletFort(byte x, byte y);
extern void MoveForts();