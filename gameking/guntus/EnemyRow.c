#include "EnemyRow.h"
#include "Coord.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"
#include "MovingEnemy.h"
#include "Sound.h"
#include "Bang.h"
#include "Enemy.h"
#include "Math.h"
#include "Status.h"
#include "Team.h"
#include "Fighter.h"
#include "VVram.h"

extern void _deb();

constexpr byte MaxCount = 5;
constexpr byte MinInitialX = (WindowWidth - 8 * 2) / 2;
constexpr byte RangeX = WindowWidth * CoordRate;
constexpr byte ColumnCount = 12;
constexpr byte Top = 2;

EnemyRow[MaxCount] EnemyRows;
byte EnemyRowCount;
byte EnemyRowLeft, EnemyRowWidth;
sbyte EnemyRowDirection;

static const byte[] columns = { 4, 1, 0, 11, 5, 10, 9, 2, 8, 6, 3, 7, };
static byte nextRow, nextColumn;

static const byte[] Points = { 1, 2, 5 };

void InitEnemyRows()
{
    ptr<EnemyRow> pRow;
    for (pRow : EnemyRows) {
        pRow->memberCount = 0;
        pRow->flags[0] = 0;
        pRow->flags[1] = 0;
    };
    EnemyRowCount = pStage->rowCount;
    EnemyRowLeft = (MinInitialX + (pStage->min << 1)) << CoordShift;
    EnemyRowWidth = ((pStage->max - pStage->min + 1) << 1) << CoordShift;
    EnemyRowDirection = -1;
    BackgroundChanged = true;
    nextRow = EnemyRowCount - 1;
    nextColumn = 0;
}


byte FixedEnemyY(byte target)
{
    return ((target & 0xf0) >> (3 - CoordShift)) + Top * CoordRate;
}


byte FixedEnemyX(byte target)
{
    return ((target & 0x0f) << (CoordShift + 1)) + EnemyRowLeft;
}


void DrawEnemyRows()
{
    constexpr byte Char_AS00 = 0x02;
    constexpr byte Char_AS20 = 0x20;
    constexpr byte Char_A010 = 0x8e;
    constexpr byte Char_A230 = 0xe0;
    constexpr byte Char_B010 = 0xce;
    constexpr byte Char_CS00 = 0x03;
    constexpr byte Char_C010 = 0xc3;
    constexpr byte Char_A1S1 = 0x08;
    constexpr byte Char_A3S1 = 0x80;
    constexpr byte Char_A011 = 0x2b;
    constexpr byte Char_A231 = 0xb0;
    constexpr byte Char_B011 = 0x3b;
    constexpr byte Char_C1S1 = 0x0c;
    constexpr byte Char_C011 = 0x3c;
    static const byte[] Chars = {
		// shift0
		Char_AS00, Char_AS20, Char_Space, Char_Space, Char_AS00, Char_AS20, Char_A010, Char_A230, 
		Char_AS00, Char_AS20, Char_Space, Char_Space, Char_AS00, Char_AS20, Char_B010, Char_AS20, 
		Char_CS00, Char_AS20, Char_Space, Char_Space, Char_CS00, Char_AS20, Char_C010, Char_AS20, 
		// shift1
		Char_Space, Char_Space, Char_A1S1, Char_A3S1, Char_A1S1, Char_A3S1, Char_A011, Char_A231, 
		Char_Space, Char_Space, Char_A1S1, Char_A3S1, Char_A1S1, Char_A3S1, Char_B011, Char_A3S1, 
		Char_Space, Char_Space, Char_C1S1, Char_A3S1, Char_C1S1, Char_A3S1, Char_C011, Char_A3S1, 
    };
    ptr<EnemyRow> pRow;
    byte leftCoord;
    ptr<byte> pVVram, pCharBase;
    {
        byte i;
        pCharBase = Chars;
        i = EnemyRowLeft & CoordMask;
        while (i != 0) {
            pCharBase += 8 * 3;
            --i;
        }
    }
    leftCoord = (EnemyRowLeft >> CoordShift);
    pVVram = VVramPtr(leftCoord, Top);
    for (pRow : EnemyRows) {
        byte n;
        n = pRow->memberCount;
        if (pRow->memberCount != 0) {
            ptr<byte> pChars, pUpper, pLower;
            byte mask, bits, width;
            bool leftLive;
            ptr<byte> pFlag;
            pChars = pCharBase + (word)(pRow->type << 3);
            pUpper = pVVram;
            pLower = pVVram + WindowWidth;
            leftLive = false;
            pFlag = pRow->flags;
            bits = *pFlag; ++pFlag;
            mask = 0x01;
            width = 0;
            repeat(ColumnCount) {
                if ((bits & mask) != 0) {
                    --n;
                    if (leftLive) {
                        *pUpper = pChars[4];
                        *pLower = pChars[5];
                    }
                    else {
                        *pUpper = pChars[0];
                        *pLower = pChars[1];
                    }
                    ++pUpper;
                    *pUpper = pChars[6];
                    ++pLower;
                    *pLower = pChars[7];
                    leftLive = true;
                }
                else {
                    if (leftLive) {
                        *pUpper = pChars[2];
                        *pLower = pChars[3];
                    }
                    else {
                        *pUpper = Char_Space;
                        *pLower = Char_Space;
                    }
                    ++pUpper;
                    *pUpper = Char_Space;
                    ++pLower;
                    *pLower = Char_Space;
                    leftLive = false;
                }
                mask <<= 1;
                if (mask == 0) {
                    bits = *pFlag; ++pFlag;
                    mask = 0x01;
                }
                ++pUpper;
                ++pLower;
                width += 2;
                if (n == 0) goto exit;
            }
            exit:
            if ((EnemyRowLeft & CoordMask) != 0) {
                *pUpper = pChars[2];
                *pLower = pChars[3];
                ++width;
            }
        }
        pVVram += WindowWidth * 2;
    }
}


void AddEnemyRowMember(byte target, byte type)
{
    ptr<EnemyRow> pRow;
    byte column;
    pRow = EnemyRows + (target >> 4);
    ++pRow->memberCount;
    pRow->type = type;
    column = target & 0x0f;
    pRow->flags[column >> 3] |= (0x01 << (column & 7));
    BackgroundChanged = true;
}


static bool StartAttacking(byte rowIndex)
{
    ptr<EnemyRow> pRow;
    pRow = EnemyRows + rowIndex;
    if (pRow->memberCount != 0) {
        byte columnIndex, byteIndex, bit;
        columnIndex = columns[nextColumn]; ++nextColumn;
        if (nextColumn >= ColumnCount) {
            nextColumn = 0;
        }
        byteIndex = columnIndex >> 3;
        bit = 0x01 << (columnIndex & 7);
        if ((pRow->flags[byteIndex] & bit) != 0) {
            ptr<MovingEnemy> pEnemy;
            pEnemy = StartMovingEnemy(MovingEnemy_Attack, pRow->type);
            if (pEnemy != nullptr) {
                pEnemy->x = EnemyRowLeft + (columnIndex << (CoordShift + 1));
                pEnemy->y = (rowIndex << (CoordShift + 1)) + Top * CoordRate;
                pEnemy->target = (rowIndex << 4) | columnIndex;
                pEnemy->bulletCount = CurrentStage + 1;
                pRow->flags[byteIndex] &= ~bit;
                --pRow->memberCount;
                return true;
            }
        }
    }   
    return false;
}

static void Destroy(ptr<EnemyRow> pRow, byte x, byte y)
{
    BackgroundChanged = true;
    Sound_SmallBang();
    StartBang(x + CoordRate, y + CoordRate, false);
    --EnemyCount;
    --pRow->memberCount;
    AddScore(Points[pRow->type]);
}


void MoveEnemyRows()
{
    byte oldCoord, newX, newCoord;
    oldCoord = EnemyRowLeft >> CoordShift;
    newX = EnemyRowLeft + EnemyRowDirection;
    if (newX >= RangeX || newX + EnemyRowWidth >= RangeX) {
        EnemyRowDirection = -EnemyRowDirection;
        newX = EnemyRowLeft + EnemyRowDirection;
    }
    EnemyRowLeft = newX;
    newCoord = EnemyRowLeft >> CoordShift;
    if (newCoord != oldCoord) {
        if (FormationCount == 0 && FreeEnemyCount != 0) {
            repeat (MaxCount) {
                byte rowIndex;
                rowIndex = nextRow; --nextRow;
                if (nextRow >= EnemyRowCount) {
                    nextRow = EnemyRowCount - 1;
                }
                if (StartAttacking(rowIndex)) break;
            }
        }
    }
    BackgroundChanged = true;
    {
        byte y;
        ptr<EnemyRow> pRow;
        y = Top * CoordRate;
        for (pRow : EnemyRows) {
            if (pRow->memberCount != 0) {
                byte x, mask, bits;
                ptr<byte> pFlag;
                x = EnemyRowLeft;
                pFlag = pRow->flags;
                bits = *pFlag;
                mask = 0x01;
                repeat(ColumnCount) {            
                    if ((bits & mask) != 0) {
                        if (HitEnemyFighter(x, y)) {
                            bits &= ~mask;
                            *pFlag = bits;
                            Destroy(pRow, x, y);
                            goto endHit;
                        }
                    }
                    mask <<= 1;
                    if (mask == 0) {
                        ++pFlag;
                        bits = *pFlag;
                        mask = 0x01;
                    }
                    x += CoordRate * 2;
                }
            }
            y += CoordRate * 2;
        }
        endHit:;
    }
}


bool HitEnemyRows(byte bulletX, byte bulletY)
{
    ptr<EnemyRow> pRow;
    byte y;
    y = Top * CoordRate;
    for (pRow : EnemyRows) {
        if (pRow->memberCount != 0) {
            byte enemyX, mask, bits;
            ptr<byte> pFlag;
            enemyX = EnemyRowLeft;
            pFlag = pRow->flags;
            bits = *pFlag;
            mask = 0x01;
            repeat(ColumnCount) {            
                if ((bits & mask) != 0) {
                    if (HitBulletEnemy(bulletX, bulletY, enemyX, y)) {
                        bits &= ~mask;
                        *pFlag = bits;
                        Destroy(pRow, enemyX, y);
                        return true;
                    }
                }
                mask <<= 1;
                if (mask == 0) {
                    ++pFlag;
                    bits = *pFlag;
                    mask = 0x01;
                }
                enemyX += CoordRate * 2;
            }
        }
        y += CoordRate * 2;
    }
    return false;
}
