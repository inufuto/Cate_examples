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

constexpr byte Ufo_TypeMask = 0x03;
constexpr byte Ufo_Time = 0x04;
constexpr byte Ufo_TimeMask = 0x1c;

static const byte[] Points = { 10, 4, 6 };

UfoRow[RowCount] UfoRows;
byte UfoCount;
byte UfoRowCenterX;
byte UfoRowCenterXd;
bool UfoMoved;
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
        byte count = 0;
        byte x = 0; 
        ptr<byte> pColumn = pRow->columns;
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
    UfoCount = 0;
    ptr<byte> pSource = pStage->bytes;
    ptr<UfoRow> pRow;
    for (pRow : UfoRows) {
        ptr<byte> pDestination = pRow->columns;
        repeat (SourceByteCount / RowCount) {
            byte source = *pSource; ++pSource;
            repeat (ColumnCount) {
                *pDestination = source & 3; ++pDestination;
                source >>= 2;
            }
        }
    }
    UfoMoved = false;
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
	const byte[] CharsO30 = {
		// O30
		Char_UfoOS00, Char_UfoOS01, Char_UfoOS02, Char_UfoOS03, Char_UfoO3S4, Char_UfoO3S5, Char_UfoO3S6, Char_UfoO3S7, 
	};
	const byte[] CharsO74 = {
		// O74
		Char_UfoOS40, Char_UfoOS41, Char_UfoOS42, Char_Space, Char_Space, Char_UfoO7S5, Char_UfoO7S6, Char_UfoO7S7, 
	};
	const byte[] CharsOS0 = {
		// OS0
		Char_UfoOS00, Char_UfoOS01, Char_UfoOS02, Char_UfoOS03, Char_Space, Char_Space, Char_Space, Char_Space, 
	};
	const byte[] CharsOS4 = {
		// OS4
		Char_UfoOS40, Char_UfoOS41, Char_UfoOS42, Char_Space, Char_Space, Char_Space, Char_Space, Char_Space, 
	};
	const byte[] CharsO03 = {
		// O01
		Char_UfoO010, Char_UfoO011, Char_UfoO012, Char_UfoO013, Char_UfoO014, Char_UfoO015, Char_UfoO016, Char_UfoO017, 
		// O12
		Char_UfoO120, Char_UfoO121, Char_UfoO122, Char_UfoO123, Char_UfoO124, Char_UfoO125, Char_UfoO126, Char_UfoO127, 
		// O23
		Char_UfoO230, Char_UfoO231, Char_UfoO232, Char_UfoO233, Char_UfoO234, Char_UfoO235, Char_UfoO236, Char_UfoO237, 
	};
	const byte[] CharsO3S = {
		// O3S
		Char_Space, Char_Space, Char_Space, Char_Space, Char_UfoO3S4, Char_UfoO3S5, Char_UfoO3S6, Char_UfoO3S7, 
	};
	const byte[] CharsO7S = {
		// O7S
		Char_Space, Char_Space, Char_Space, Char_Space, Char_Space, Char_UfoO7S5, Char_UfoO7S6, Char_UfoO7S7, 
	};
	const byte[] CharsA47 = {
		// A45
		Char_UfoA450, Char_UfoA451, Char_UfoA452, Char_UfoA453, Char_UfoA454, Char_UfoA455, Char_UfoA456, Char_UfoO457, 
		// A56
		Char_UfoA560, Char_UfoA561, Char_UfoA562, Char_UfoA563, Char_UfoA563, Char_UfoA565, Char_UfoA566, Char_UfoA567, 
		// A67
		Char_UfoO670, Char_UfoA671, Char_UfoA672, Char_UfoA673, Char_UfoA674, Char_UfoA675, Char_UfoA676, Char_UfoA677, 
	};
	const byte[] CharsB47 = {
		// B45
		Char_UfoB450, Char_UfoB451, Char_UfoB452, Char_UfoB453, Char_UfoB454, Char_UfoO455, Char_UfoO456, Char_UfoO457, 
		// B56
		Char_UfoB560, Char_UfoB561, Char_UfoB562, Char_UfoB563, Char_UfoB564, Char_UfoB565, Char_UfoB566, Char_UfoB567, 
		// B67
		Char_UfoO670, Char_UfoO671, Char_UfoO672, Char_UfoB673, Char_UfoB674, Char_UfoB675, Char_UfoB676, Char_UfoB677, 
	};
	const byte[] CharsC47 = {
		// C45
		Char_UfoC450, Char_UfoC451, Char_UfoC452, Char_UfoC453, Char_UfoC454, Char_UfoC455, Char_UfoO456, Char_UfoO457, 
		// C56
		Char_UfoC560, Char_UfoC561, Char_UfoC562, Char_UfoC563, Char_UfoC564, Char_UfoC565, Char_UfoC566, Char_UfoC567, 
		// C67
		Char_UfoO670, Char_UfoO671, Char_UfoO672, Char_UfoO673, Char_UfoC674, Char_UfoC675, Char_UfoC676, Char_UfoC677, 
	};
	const byte[] CharsO47 = {
		// O45
		Char_Space, Char_UfoO451, Char_UfoO452, Char_UfoO453, Char_UfoO454, Char_UfoO455, Char_UfoO456, Char_UfoO457, 
		// O56
		Char_Space, Char_Space, Char_Space, Char_Space, Char_Space, Char_Space, Char_Space, Char_Space, 
		// O67
		Char_UfoO670, Char_UfoO671, Char_UfoO672, Char_UfoO673, Char_UfoO674, Char_UfoO675, Char_UfoO676, Char_Space, 
	};
    static const ptr<byte>[] LowerCharses = {
        CharsA47,
        CharsB47,
        CharsC47,
    };
    byte leftCoord;
    ptr<byte> pVVram;
    ptr<UfoRow> pRow;
    leftCoord = 
        UfoRowCenterX + (VVramWidth / 2 - UnitWidth * ColumnCount / 2) 
        + LeftSpace;
    pVVram = VVram + (word)leftCoord;
    for (pRow : UfoRows) {
        byte n;
        n = pRow->memberCount;
        if (n != 0) {
            ptr<byte> pColumn, pUpper, pLower;
            byte x, leftType;
            pColumn = pRow->columns;
            pUpper = pVVram;
            pLower = pVVram + VVramWidth;
            leftType = 0;
            x = 0;
            repeat (ColumnCount) {
                byte source;
                source = *pColumn; ++pColumn;
                if (x > RightEnd) break;
                if (x >= LeftSpace) {
                    byte type = source & Ufo_TypeMask;
                    if (type != 0) {
                        ptr<byte> pc;
                        if (leftType != 0) {
                            *pUpper = CharsO30[UfoRowCenterXd];
                            *pLower = CharsO74[UfoRowCenterXd]; 
                        }
                        else {
                            *pUpper = CharsOS0[UfoRowCenterXd];
                            *pLower = CharsOS4[UfoRowCenterXd];
                        }
                        ++pUpper; ++pLower;
                        pc = CharsO03 + UfoRowCenterXd;
                        repeat (3) {
                            *pUpper = *pc; ++pUpper;
                            pc += CoordRate;
                        }
                        if ((source & Ufo_TimeMask) != 0) {
                            pc = CharsO47 + UfoRowCenterXd;
                        }
                        else {
                            pc = LowerCharses[type - 1] + UfoRowCenterXd;
                        }
                        repeat (3) {
                            *pLower = *pc; ++pLower;
                            pc += CoordRate;
                        }
                        leftType = type;
                    }
                    else {
                        if (leftType != 0 && UfoRowCenterXd != 0) {
                            *pUpper = CharsO3S[UfoRowCenterXd];
                            *pLower = CharsO7S[UfoRowCenterXd]; 
                        }
                        pUpper += UnitWidth;
                        pLower += UnitWidth;
                        leftType = 0;
                    }
                }
                x += UnitWidth;
                if (leftType != 0 && UfoRowCenterXd != 0) {
                    *pUpper = CharsO3S[UfoRowCenterXd];
                    *pLower = CharsO7S[UfoRowCenterXd]; 
                }
            }
        }
        pVVram += VVramWidth * 3;
    }
    UfoMoved = false;
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
        UfoRowCenterX += UfoDirection;
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
                    ((UfoRowCenterX + (VVramWidth / 2 - UnitWidth * ColumnCount / 2) + 1) << CoordShift)
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
        UfoMoved = true;
    }
    if (UfoRowCenterXd == 0) {
        byte center =
            (UfoRowCenterX + VVramWidth / 2)
            - UnitWidth * ColumnCount / 2;
        if (center + LeftSpace == 0) {
            UfoDirection = 1;
        }
        else if (center + RightEnd >= VVramWidth) {
            UfoDirection = -1;
        }
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
                ((UfoRowCenterX + (VVramWidth / 2 - UnitWidth * ColumnCount / 2)) << CoordShift)
                + UfoRowCenterXd;
            pColumn = pRow->columns;
            repeat (ColumnCount) {
                b = *pColumn;
                if (b != 0) {
                    byte bulletRight;
                    bulletRight = bulletX + CoordRate * 2;
                    if (
                        bulletX < x + (CoordRate * (UnitWidth * 2 - 1)) / 2 &&
                        (bulletRight == 0 || x + CoordRate / 2 < bulletRight)
                    ) {
                        byte type, point;
                        type = b & Ufo_TypeMask;
                        if ((b & Ufo_TimeMask) == 0) {
                            StartFallingBlock(x + CoordRate, y, type);
                        }
                        AddScore(Points[type - 1]);
                        StartSmallBang(x + CoordRate * 2, y + CoordRate * 2);
                        // Sound_SmallBang();
                        Sound_Hit();
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