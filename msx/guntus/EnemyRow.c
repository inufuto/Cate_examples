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

constexpr byte MaxCount = 8;
constexpr byte MinInitialX = (WindowWidth - 12 * 2) / 2;
constexpr byte RangeX = WindowWidth * CoordRate;
constexpr byte ColumnCount = 12;
constexpr byte Top = 2;
constexpr byte BufferWidth = ColumnCount * 2 + 1;

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
    ptr<EnemyRow> pRow;
    byte leftCoord;
    word vram;
    leftCoord = (EnemyRowLeft >> CoordShift);
    vram = (Vram + VramRowSize * Top) + (word)leftCoord;
    for (pRow : EnemyRows) {
        byte n;
        n = pRow->memberCount;
        if (pRow->memberCount != 0) {
            static byte[BufferWidth * 2] rowChars;
            ptr<byte> pTarget;
            byte mask, bits, cType, width;
            bool leftLive;
            ptr<byte> pFlag;
            FillMemory(rowChars, BufferWidth * 2, Char_Space);
            cType = (pRow->type << 3) + Char_Enemy;
            pTarget = rowChars;
            leftLive = false;
            pFlag = pRow->flags;
            bits = *pFlag; ++pFlag;
            mask = 0x01;
            width = 0;
            repeat(ColumnCount) {
                if ((bits & mask) != 0) {
                    --n;
                    if (leftLive) {
                        pTarget[0] = cType + 4;
                        pTarget[BufferWidth] = cType + 5;
                    }
                    else {
                        pTarget[0] = cType + 0;
                        pTarget[BufferWidth] = cType + 1;
                    }
                    pTarget[1] = cType + 6;
                    pTarget[BufferWidth + 1] = cType + 7;
                    leftLive = true;
                }
                else {
                    if (leftLive) {
                        pTarget[0] = cType + 2;
                        pTarget[BufferWidth] = cType + 3;
                    }
                    else {
                        pTarget[0] = Char_Space;
                        pTarget[BufferWidth] = Char_Space;
                    }
                    pTarget[1] = Char_Space;
                    pTarget[BufferWidth + 1] = Char_Space;
                    leftLive = false;
                }
                mask <<= 1;
                if (mask == 0) {
                    bits = *pFlag; ++pFlag;
                    mask = 0x01;
                }
                pTarget += 2;
                width += 2;
                if (n == 0) goto exit;
            }
            exit:
            if ((EnemyRowLeft & 7) != 0) {
                pTarget[0] = cType + 2;
                pTarget[BufferWidth] = cType + 3;
                ++width;
            }
            EnemyRowsToVram(vram, rowChars, width);
        }
        vram += VramRowSize * 2;
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
    else {
        UpdateEnemyChars();
        SwitchChars();
    }
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
