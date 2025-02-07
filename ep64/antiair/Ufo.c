#include "Ufo.h"
#include "VVram.h"
#include "Movable.h"
#include "CopyMemory.h"
#include "Chars.h"
#include "Bang.h"
#include "Sound.h"
#include "Block.h"
#include "Math.h"
#include "Status.h"

extern void _deb();

constexpr byte UnitWidth = 4;
constexpr byte RowHeight = 3;
// constexpr byte Top = StatusHeight;

constexpr byte Ufo_TypeMask = 0x03;
constexpr byte Ufo_Time = 0x04;
constexpr byte Ufo_TimeMask = 0x1c;

static const byte[] Points = { 10, 4, 6 };

UfoRow[RowCount] UfoRows;
byte UfoCount;
byte UfoRowCenterX;
// byte UfoRowCenterXd;
static sbyte UfoDirection;
static byte LeftSpace, RightEnd;

static void Update()
{
    ptr<UfoRow> pRow;
    byte min, max;
    UfoCount = 0;
    RightEnd = 0; 
    LeftSpace = UnitWidth * ColumnCount;
    for (pRow : UfoRows) {
        byte count, x;
        ptr<byte> pColumn;
        count = 0;
        x = 0; 
        pColumn = pRow->columns;
        repeat (ColumnCount) {
            byte b;
            b = *pColumn; ++pColumn;
            if (b != 0) {
                ++count;
                if (x < LeftSpace) {
                    LeftSpace = x;
                }
                if (x > RightEnd) {
                    RightEnd = x;
                }
            }
            x += UnitWidth;
        }
        pRow->memberCount = count;
        UfoCount += count;
    }
    RightEnd += UnitWidth;
}


void InitUfos()
{
    ptr<byte> pSource;
    ptr<UfoRow> pRow;
    UfoCount = 0;
    pSource = pStage->bytes;
    for (pRow : UfoRows) {
        ptr<byte> pDestination;
        pDestination = pRow->columns;
        repeat (SourceByteCount / RowCount) {
            byte source;
            source = *pSource; ++pSource;
            repeat (4) {
                *pDestination = source & 3; ++pDestination;
                source >>= 2;
            }
        }
    }
}


void ResetUfos()
{
    UfoDirection = 1;
    UfoRowCenterX = 0;
    // UfoRowCenterXd = 0;
    Update();
}

void DrawUfos()
{
    constexpr byte BufferWidth = ColumnCount * UnitWidth + 1;
    byte leftCoord;
    ptr<byte> pVVram;
    ptr<UfoRow> pRow;
    leftCoord = 
        UfoRowCenterX + (WindowWidth / 2 - UnitWidth * ColumnCount / 2)
        + LeftSpace;
    pVVram = VVram + (word)leftCoord;
    for (pRow : UfoRows) {
        byte n;
        n = pRow->memberCount;
        if (n != 0) {
            ptr<byte> pColumn, pUpper;
            byte x;
            pColumn = pRow->columns;
            pUpper = pVVram;
            x = 0;
            repeat (ColumnCount) {
                byte source;
                byte type;
                source = *pColumn; ++pColumn;
                if (x > RightEnd) break;
                if (x >= LeftSpace) {
                    type = source & Ufo_TypeMask;
                    if (type != 0) {
                        ptr<byte> pLower;
                        pLower = pUpper + VVramWidth;
                        {
                            byte c;
                            c = Char_Ufo;
                            repeat (4) {
                                *pUpper = c; ++pUpper;
                                ++c;
                            }
                        }
                        *pLower = Char_Ufo + 4; ++pLower;
                        if ((source & Ufo_TimeMask) == 0) {
                            byte c;
                            c = Char_Block + 2 + ((type - 1) << 2);
                            *pLower = c; ++pLower;
                            ++c;
                            *pLower = c; ++pLower;
                        }
                        else {
                            *pLower = Char_Space; ++pLower;
                            *pLower = Char_Space; ++pLower;
                        }
                        *pLower = Char_Ufo + 7; ++pLower;
                    }
                    else {
                        pUpper += UnitWidth;
                    }
                }
                x += UnitWidth;
            }
        }
        pVVram += VVramWidth * 3;
    }
}


void MoveUfos()
{
    byte center;
    UfoRowCenterX += UfoDirection;
    center =
        (UfoRowCenterX + WindowWidth / 2)
        - UnitWidth * ColumnCount / 2;
    if (center + LeftSpace == 0) {
        UfoDirection = 1;
    }
    else if (center + RightEnd >= WindowWidth) {
        UfoDirection = -1;
    }
    {
        ptr<UfoRow> pRow;
        byte y;
        pRow = UfoRows;
        y = 0;
        repeat (RowCount) {
            ptr<byte> pColumn;
            byte x;
            pColumn = pRow->columns;
            x = 
                ((UfoRowCenterX + (WindowWidth / 2 - UnitWidth * ColumnCount / 2) + 1) << CoordShift);
                // + UfoRowCenterXd;
            repeat (ColumnCount) {
                byte b, type;
                b = *pColumn;
                type = b & Ufo_TypeMask;
                if (type != 0) {
                    static byte clock;
                    if ((b & Ufo_TimeMask) != 0) {
                        b -= Ufo_Time;
                    }
                    else if ((clock & 7) == 0) {
                        byte threshold;
                        threshold = CurrentStage + 2;
                        if (Rnd() < threshold && StartFallingBlock(x, y, type)) {
                            b |= Ufo_TimeMask;
                        }
                    }
                    ++clock;
                    *pColumn = b;
                }
                ++pColumn;
                x += UnitWidth * CoordRate;
            }
            ++pRow;
            y += CoordRate * 3;
        }
    }
    BackgroundChanged = true;
}

bool HitUfo(byte bulletX, byte bulletY)
{
    byte y;
    ptr<UfoRow> pRow;
    y = 0;
    for (pRow : UfoRows) {
        byte bottom;
        if (bulletY < y + CoordRate * 2 && y < bulletY + CoordRate) {
            byte x;
            byte b;
            ptr<byte> pColumn;
            x = 
                ((UfoRowCenterX + (WindowWidth / 2 - UnitWidth * ColumnCount / 2)) << CoordShift);
                // + UfoRowCenterXd;
            pColumn = pRow->columns;
            repeat (ColumnCount) {
                b = *pColumn;
                if (b != 0) {
                    if (
                        bulletX < x + (CoordRate * UnitWidth) &&
                        x + CoordRate / 2 < bulletX + CoordRate * 2
                    ) {
                        byte type, point;
                        type = b & Ufo_TypeMask;
                        if ((b & Ufo_TimeMask) == 0) {
                            StartFallingBlock(x + CoordRate, y, type);
                        }
                        AddScore(Points[type - 1]);
                        StartSmallBang(x + CoordRate * 2, y + CoordRate * 2);
                        Sound_SmallBang();
                        *pColumn = 0;
                        Update();
                        BackgroundChanged = true;
                        return true;
                    }
                }
                ++pColumn;
                x += UnitWidth * CoordRate;
            }
        }
        y += CoordRate * 3;
    }
    return false;
}