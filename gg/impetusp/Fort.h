struct Fort {
    byte x, y;
    byte life;
    byte clock;
};

extern Fort[] Forts;
extern byte FortCount;
extern byte FortDotOffset;
extern byte FortCharOffset;

extern void UpdateFortChars();
extern void DrawFort(byte x, byte y);

extern void InitForts();
extern void StartForts();
extern void MoveForts();
extern bool HitFort(byte x, byte y);
