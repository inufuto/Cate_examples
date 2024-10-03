#include "Ufo.h"
#include "Vram.h"
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
constexpr byte Top = StatusHeight;

constexpr byte Ufo_TypeMask = 0x03;
constexpr byte Ufo_Time = 0x04;
constexpr byte Ufo_TimeMask = 0x1c;

static const byte[] Points = { 10, 4, 6 };

UfoRow[RowCount] UfoRows;
byte UfoCount;
byte UfoRowCenterX;
byte UfoRowCenterXd;
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
    BackgroundChanged = true;
}


void ResetUfos()
{
    UfoDirection = 1;
    UfoRowCenterX = 0;
    UfoRowCenterXd = 0;
    Update();
}

void DrawUfos()
{
    byte leftCoord = 
        UfoRowCenterX + (WindowWidth / 2 - UnitWidth * ColumnCount / 2) 
        + LeftSpace;
    ptr<byte> pVram = Vram + VramRowSize * StatusHeight + (word)(leftCoord >> 1);
    bool upperRight = (leftCoord & 1) != 0;
    bool lowerRight = upperRight;
    byte charOffset = UfoRowCenterXd;
    ptr<UfoRow> pRow;
    for (pRow : UfoRows) {
        byte n;
        n = pRow->memberCount;
        if (n != 0) {
            ptr<byte> pColumn = pRow->columns;
            ptr<byte> pUpper = pVram;
            ptr<byte> pLower = pVram + VramRowSize;
            byte leftType = 0;
            byte x = 0;
            repeat (ColumnCount) {
                static const byte[] CharsO3S = { 0x00,0x0c, };
                static const byte[] CharsO7S = { 0x00,0xc0, };
                byte source = *pColumn; ++pColumn;
                if (x > RightEnd) break;
                if (x >= LeftSpace) {
                    byte type = source & Ufo_TypeMask;
                    if (type != 0) {
                        if (leftType != 0) {
                            static const byte[] CharsO30 = { 0x3f,0x0f, };
                            static const byte[] CharsO74 = { 0xc0,0xf0, };
                            pUpper = Put(pUpper, CharsO30[charOffset], upperRight); upperRight = !upperRight;
                            pLower = Put(pLower, CharsO74[charOffset], lowerRight); lowerRight = !lowerRight;
                        }
                        else {
                            static const byte[] CharsOS0 = { 0x3f,0x03, };
                            static const byte[] CharsOS4 = { 0xc0,0x30, };
                            pUpper = Put(pUpper, CharsOS0[charOffset], upperRight); upperRight = !upperRight;
                            pLower = Put(pLower, CharsOS4[charOffset], lowerRight); lowerRight = !lowerRight;
                        }
                        static const byte[] CharsO = {
                            0xf7,0xfd,
                            0xfd,0xff,
                            0xcf,0xf7,
                        };
                        ptr<byte> pChars = CharsO + charOffset;
                        repeat (3) {
                            pUpper = Put(pUpper, *pChars, upperRight); upperRight = !upperRight;
                            pChars += 2;
                        }
                        if ((source & Ufo_TimeMask) != 0) {
                            static const byte[] CharsO45 = { 0x00,0x00, };
                            static const byte[] CharsO67 = { 0x30,0x00, };
                            pLower = Put(pLower, CharsO45[charOffset], lowerRight); lowerRight = !lowerRight;
                            pLower = Put(pLower, Char_Space, lowerRight); lowerRight = !lowerRight;
                            pLower = Put(pLower, CharsO67[charOffset], lowerRight); lowerRight = !lowerRight;
                        }
                        else {
                            static const byte[] CharsA = { 
                                0x9a,0x22,
                                0x6a,0x5a,
                                0x30,0x88,
                            };
                            static const byte[] CharsB = {
                                0xa2,0x20,
                                0xa8,0xaa,
                                0x30,0x80,
                            };
                            static const byte[] CharsC = { 
                                0xf3,0x30,
                                0x3c,0xcf,
                                0x30,0xc0,
                            };
                            static const ptr<byte>[] LowerCharPtrs = {
                                CharsA, CharsB, CharsC
                            };
                            ptr<byte> pChars = LowerCharPtrs[type - 1] + charOffset;
                            repeat (3) {
                                pLower = Put(pLower, *pChars, lowerRight); lowerRight = !lowerRight;
                                pChars += 2;
                            }
                        }
                        leftType = type;
                    }
                    else {
                        if (leftType != 0) {
                            Put(pUpper, CharsO3S[charOffset], upperRight);
                            Put(pLower, CharsO7S[charOffset], lowerRight);
                        }
                        pUpper += UnitWidth / 2;
                        pLower += UnitWidth / 2;
                        leftType = 0;
                    }
                }
                x += UnitWidth;
                // if (leftType != 0) {
                //     pUpper = Put(pUpper, CharsO3S[charOffset], upperRight); upperRight = !upperRight;
                //     pLower = Put(pLower, CharsO7S[charOffset], lowerRight); lowerRight = !lowerRight; 
                // }
            }
        }
        pVram += VramRowSize * 3;
    }
}


void MoveUfos()
{
    UfoRowCenterXd = (UfoRowCenterXd + UfoDirection) & CoordMask;
    if (UfoDirection == 1) {
        BackgroundChanged = UfoRowCenterXd == 0;
    }
    else {
        BackgroundChanged = UfoRowCenterXd == CoordMask;
    }
    if (BackgroundChanged) {
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
                    ((UfoRowCenterX + (WindowWidth / 2 - UnitWidth * ColumnCount / 2) + 1) << CoordShift)
                    + UfoRowCenterXd;
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
    }
    else {
        BackgroundChanged = true;
    }
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
                ((UfoRowCenterX + (WindowWidth / 2 - UnitWidth * ColumnCount / 2)) << CoordShift)
                + UfoRowCenterXd;
            pColumn = pRow->columns;
            repeat (ColumnCount) {
                b = *pColumn;
                if (b != 0) {
                    if (
                        bulletX < x + (CoordRate * (UnitWidth * 2 - 1)) / 2 &&
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
                        // Sound_Hit();
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