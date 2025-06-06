#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "VVram.h"
#include "Vram.h"

extern void _deb();

constexpr byte SpriteColor = 14;
constexpr byte MaxCount = 4; 
constexpr byte MaxTime = 6;
static const word[] Values = { 10, 20, 40, 80 };
static const byte[] Chars = { 0x31, 0x32, 0x34, 0x38 };

struct Point {
    byte x, y;
    byte c;
    byte time;
};
Point[MaxCount] Points;
byte PointRate;


void InitPoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        pPoint->time = 0;
    }
}


void StartPoint(byte x, byte y)
{
    AddScore(Values[PointRate]);
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time == 0) {
            pPoint->time = MaxTime << CoordShift;
            if (x > WindowWidth - 2) {
                x = WindowWidth - 2;
            }
            pPoint->x = x;
            pPoint->y = y;
            pPoint->c = Chars[PointRate];
            if (PointRate < 4 - 1) {
                ++PointRate;
            }
            return;
        }
    }
}


void UpdatePoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time != 0) {
            --pPoint->time;
        }
    }
}


void DrawPoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time != 0) {
            ptr<byte> pVVram = VVramFront + VVramOffset(pPoint->x, pPoint->y);
            pVVram = VPut(pVVram, pPoint->c);
            pVVram = VPut(pVVram, 0x30);
            VPut(pVVram, 0x30);
        }
    }
}