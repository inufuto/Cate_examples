#include "Point.h"
#include "Main.h"
#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"

extern void _deb();

constexpr byte Count = 8;
constexpr byte RightEnd = VVramWidth * 2 - 3;
constexpr byte Time = 3;
constexpr byte InvalidChar = 0;
static const word[] Values = { 10, 20, 40, 80 };
static const byte[] Chars = { '1', '2', '4', '8' } ;

struct Point {
    ptr<byte> pVram;
    ptr<byte> pBackup;
    byte c;
    byte time;
    byte shift;
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
    ptr<Point> pPoint;
    AddScore(Values[rate]);
    for (pPoint: Points) {
        if (pPoint->c != InvalidChar) continue;
        if (x >= RightEnd) {
            x = RightEnd;
        }
        pPoint->shift = x & 1;
        x >>= 1;
        y >>= 1;
        pPoint->pVram = VramPtr(x, y);
        pPoint->pBackup = BackupPtr(x, y);
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
            ptr<byte> pBackup;
            pBackup = pPoint->pBackup;
            repeat (2) {
                *pBackup = 0xff;
                ++pBackup;
            }
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
        byte shift = pPoint->shift;
        pVram = PrintC(pPoint->pVram, pPoint->c, shift);
        repeat (2) {
            shift ^= 1;
            pVram = PrintC(pVram, '0', shift);
        }
    }
}
