extern byte LineFirstX, LineFirstY;
extern byte LineLastX, LineLastY;
extern byte LinePrevX, LinePrevY;
extern byte LineCharOffset;

extern void GrowLeavingLine(byte direction);
extern void GrowEnteringLine(byte direction);
extern bool IsSurrounded(byte x, byte y);
