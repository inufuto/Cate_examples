#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Vram.h"

extern void _deb();

constexpr byte SpriteColor = 14;
constexpr byte MaxCount = 4; 
constexpr byte MaxTime = 6;
static const word[] Values = { 10, 20, 40, 80 };
static const byte[] Chars = { '1', '2', '4', '8' };

struct Point {
    byte x, y;
    byte c;
    byte time;
};
Point[MaxCount] Points;


void InitPoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        pPoint->time = 0;
    }
}


void StartPoint(byte x, byte y, byte rate)
{
    AddScore(Values[rate]);
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time == 0) {
            pPoint->time = MaxTime << CoordShift;
            pPoint->x = x;
            pPoint->y = y;
            pPoint->c = Chars[rate];
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
    static const word[] Offsets = {
        VramRowSize * 1,
        VramRowSize * 2,
        VramRowSize * 2,
        VramRowSize * 3,
        VramRowSize * 4,
        VramRowSize * 4,
        VramRowSize * 5,
        VramRowSize * 6,
        VramRowSize * 6,
        VramRowSize * 7,
        VramRowSize * 8,
        VramRowSize * 8,
        VramRowSize * 9,
        VramRowSize * 10,
        VramRowSize * 10,
        VramRowSize * 11,
        VramRowSize * 12,
        VramRowSize * 12,
        VramRowSize * 13,
        VramRowSize * 14,
        VramRowSize * 14,
        VramRowSize * 15,
    };
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time != 0) {
            ptr<byte> pVram = Vram + Offsets[pPoint->y] + (pPoint->x << 1);
            *pVram = pPoint->c; ++pVram;
            *pVram = '0'; ++pVram;
            *pVram = '0';
        }
    }
}