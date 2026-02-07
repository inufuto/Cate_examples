struct Flag {
    byte column, floor;
};

extern Flag[] Flags;
extern byte FlagCount;

extern void InitFlags();
extern void PutFlags();
extern void HitFlags(byte column, byte floor);
extern void SlideFlags(sbyte dx);
extern void DrawFlags();
extern void BlinkFlags();
extern void HitFlagsShift(sbyte offset);
