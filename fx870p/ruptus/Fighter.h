extern byte FighterX, FighterY;
extern sbyte FighterDx, FighterDy;
extern byte FighterDirection;
extern sbyte FighterDyingCount;

extern void InitFighter(byte x, byte y);
extern void ControlFighter();
extern void MoveFighter();
extern bool HitFighter(byte x, byte y, byte size);
