struct Fort {
    byte x, y;
    byte targetX;
    byte life;
    byte clock;
    byte oldX, oldY;
};

extern Fort[] Forts;
extern byte FortCount;
extern byte[] FortPattern;

extern void InitForts();
extern void StartForts();
extern bool HitBulletFort(byte x, byte y);
extern void MoveForts();
extern void DrawForts();
extern void EraseForts();