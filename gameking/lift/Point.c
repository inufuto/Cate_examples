#include "Point.h"
#include "Vram.h"
#include "Main.h"
#include "Stage.h"

constexpr byte Count = 4;
constexpr byte RightEnd = 48 - 4 * 3;
constexpr byte Time = 6;
constexpr byte InvalidChar = 0;
static const word[] Values = { 10, 20, 40, 80 };
static const byte[] Chars = { '1', '2', '4', '8' } ;

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
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->c != InvalidChar) continue;
        if (x >= RightEnd + 1) {
            x = RightEnd;
        }
        pPoint->pVram = SpriteLayer + VramOffset(x >> CoordShift, (y >> CoordShift) + StageTop);
        pPoint->time = Time << CoordShift;
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
        ptr<byte> pVram;
        if (pPoint->c == InvalidChar) continue;
        pVram = PrintC(pPoint->pVram, pPoint->c);
        repeat (2) {
            pVram = PrintC(pVram, '0');
        }
    }
}
