struct Fort {
    byte x, y;
    byte targetY;
    byte life;
    byte clock;
};

extern Fort[] Forts;
extern byte FortCount;
extern byte FortDotOffset;


extern void InitForts();
extern void StartForts();
extern void DrawForts();
extern void MoveForts();
extern bool HitFort(byte x, byte y);
