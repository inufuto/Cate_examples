#include "Movable.h"

constexpr byte Point_time = 3;
constexpr byte Point_unitSize = 4;

// struct Point : Movable {
//     byte time;
// };

// extern Point[] Points;
extern byte PointRate;

extern void InitPoints();
extern void StartPoint(byte x, byte y);
extern void UpdatePoints();
