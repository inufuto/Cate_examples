struct Fort {
    byte x, y;
    byte life;
    byte clock;
    byte sprite;
};

extern Fort[] Forts;
extern byte FortCount;
extern byte FortDotOffset;

extern void InitForts();
extern void StartForts();
extern void MoveForts();
extern bool HitFort(byte x, byte y);
