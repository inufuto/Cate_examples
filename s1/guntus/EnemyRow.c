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
#include "CopyMemory.h"

extern void _deb();

constexpr byte MaxCount = 8;
constexpr byte MinInitialX = (WindowWidth - 12 * 2) / 2;
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
    static const byte[] Chars = {
		// shift0
		Char_AS00, Char_AS20, Char_Space, Char_Space, Char_AS00, Char_AS20, Char_A010, Char_A230, 
		Char_BS00, Char_BS20, Char_Space, Char_Space, Char_BS00, Char_BS20, Char_B010, Char_B230, 
		Char_CS00, Char_CS20, Char_Space, Char_Space, Char_CS00, Char_CS20, Char_C010, Char_C230, 
		// shift4
		Char_AS04, Char_AS24, Char_A1S4, Char_A3S4, Char_A104, Char_A324, Char_A014, Char_A234, 
		Char_BS04, Char_BS24, Char_B1S4, Char_B3S4, Char_B104, Char_B324, Char_B014, Char_B234, 
		Char_CS04, Char_CS24, Char_C1S4, Char_C3S4, Char_C104, Char_C324, Char_C014, Char_C234, 
    };
    ptr<EnemyRow> pRow;
    byte leftCoord;
    ptr<byte> pVram, pCharBase;
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
    pVram = NextPage() + VramOffset(leftCoord, Top);
    for (pRow : EnemyRows) {
        byte n;
        n = pRow->memberCount;
        if (pRow->memberCount != 0) {
            ptr<byte> pChars, pUpper, pLower;
            byte mask, bits, width;
            bool leftLive;
            ptr<byte> pFlag;
            pChars = pCharBase + (word)(pRow->type << 3);
            pUpper = pVram;
            pLower = pVram + VramRowSize;
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
        pVram += VramRowSize * 2;
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
    // Sound_Hit();
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
        BackgroundChanged = true;
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
    // else {
    //     UpdateEnemyChars();
    // }
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
