#include "Movable.h"

struct Point {
    ptr<byte> pVram;
    byte c;
    byte time;
};
extern Point[] Points;
extern byte PointRate;

extern void InitPoints();
extern void StartPoint(byte x, byte y);
extern void UpdatePoints();
