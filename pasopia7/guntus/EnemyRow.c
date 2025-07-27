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

constexpr byte MaxCount = 8;
constexpr byte MinInitialX = (WindowWidth - 12 * 2) / 2;
constexpr byte RangeX = WindowWidth * CoordRate;
constexpr byte ColumnCount = 12;
constexpr byte Top = 2;

EnemyRow[MaxCount] EnemyRows;
byte EnemyRowCount;
byte EnemyRowLeft, EnemyRowWidth;
bool EnemyRowChanged;
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
    EnemyRowChanged = true;
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
    ptr<EnemyRow> pRow;
    ptr<byte> pVVramRow;
    byte y;
    y = Top;
    pVVramRow = (VVramBack + VVramWidth * Top) + (word)(EnemyRowLeft << 1);
    for (pRow : EnemyRows) {
        byte n;
        n = pRow->memberCount;
        if (n != 0) {
            ptr<byte> pVVram;
            byte mask, bits, type, cType;
            ptr<byte> pFlag;
            bool left;
            type = pRow->type;
            cType = (type << (3 + 3)) + Char_Enemy;
            pVVram = pVVramRow;
            pFlag = pRow->flags;
            bits = *pFlag; ++pFlag;
            mask = 0x01;
            repeat(ColumnCount) {
                if ((bits & mask) != 0) {
                    pVVram = VPut2C(pVVram, cType);
                    --n;
                }
                else {
                    pVVram += 4 * VVramStep;
                }

                mask <<= 1;
                if (mask == 0) {
                    bits = *pFlag; ++pFlag;
                    mask = 0x01;
                }
                if (n == 0) goto exit;
            }
            exit:
            SetRowFlags(y, 3);
        }
        y += 2;
        pVVramRow += VVramWidth * 2;
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
    byte oldX, newX;
    oldX = EnemyRowLeft;
    newX = EnemyRowLeft + EnemyRowDirection;
    if (newX >= RangeX || newX + EnemyRowWidth >= RangeX) {
        EnemyRowDirection = -EnemyRowDirection;
        newX = EnemyRowLeft + EnemyRowDirection;
    }
    EnemyRowLeft = newX;
    if (newX != oldX) {
        EnemyRowChanged = true;
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
    //     SwitchChars();
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
