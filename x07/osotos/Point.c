#include "Point.h"
#include "Main.h"
#include "Vram.h"
#include "VVram.h"

extern void _deb();

constexpr byte Count = 4;
constexpr byte RightEnd = VVramWidth - 3 * 2;
constexpr byte Time = 2;
constexpr byte InvalidChar = 0;
static const word[] Values = { 10, 20, 40, 80 };
static const byte[] Chars = { '1', '2', '4', '8' } ;

struct Point {
    ptr<byte> pVVram;
    byte c;
    byte time;
};
Point[Count] Points;


void InitPoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        pPoint->c = InvalidChar;
    }
}


void StartPoint(byte x, byte y, byte rate)
{
    AddScore(Values[rate]);
    y -= TopMargin;
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->c != InvalidChar) continue;
        if (x >= RightEnd + 1) {
            x = RightEnd;
        }
        pPoint->pVVram = VVramPtr(x, y);
        pPoint->time = Time;
        pPoint->c = Chars[rate];
        return;
    }
}


void UpdatePoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->c == InvalidChar) continue;
        if (pPoint->time == 0) {
            pPoint->c = InvalidChar;
        }
        else {
            --pPoint->time;
        }
    }
}


void DrawPoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->c == InvalidChar) continue;
        ptr<byte> pVVram = VPrintC(pPoint->pVVram, pPoint->c);
        repeat (2) {
            pVVram = VPrintC(pVVram, '0');
        }
    }
}
