#include "Movable.h"

struct Point : Movable {
    byte time;
};

extern Point[] Points;
extern byte PointRate;

extern void InitPoints();
extern void StartPoint(byte x, byte y, byte rate);
extern void UpdatePoints();
