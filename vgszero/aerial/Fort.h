struct Fort {
    byte x, y;
    byte targetX;
    byte life;
    byte clock;
    byte sprite;
};

extern Fort[] Forts;
extern byte FortCount;

extern void InitForts();
extern void StartForts();
extern bool HitBulletFort(byte x, byte y);
extern void MoveForts();