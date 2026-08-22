#include "Debri.h"
#include "Sprite.h"
#include "Chars.h"
#include "Stage.h"

extern void PollVsync();

// constexpr byte SpriteColor = 7;
constexpr byte InvlidY = 0xe0;

Debri[DebriSpriteCount] Debris;
static byte ScanningRow;

void InitDebris()
{
    byte sprite = Sprite_Debri;
    ptr<Debri> pDebri;
    for (pDebri : Debris) {
        pDebri->y = InvlidY;
        pDebri->sprite = sprite;
        ++sprite;
    }
    ScanningRow = 0;
}


static void Show(ptr<Debri> pDebri)
{
    ShowSprite(pDebri, Pattern_Monster_Fall);
}

void StartDebri(byte x, byte y)
{
    ptr<Debri> pDebri;
    for (pDebri : Debris) {
        if (pDebri->y == InvlidY) {
            pDebri->x = x;
            pDebri->y = y;
            Show(pDebri);
            return;
        }
    }
}


void FallDebris()
{
    ptr<Debri> pDebri;
    for (pDebri : Debris) {
        if (pDebri->y != InvlidY) {
            byte column = (pDebri->x + CoordRate) >> CellCoordShift;
            byte row = (pDebri->y + CellCoordShift) >> CellCoordShift;
            byte lowerCell = GetCell(column, row + 1);
            if (lowerCell == Cell_Floor || (lowerCell & Cell_Debri) != 0) {
                SetCell(column, row, GetCell(column, row) | Cell_Debri);
                pDebri->y = InvlidY;
                HideSprite(pDebri->sprite);
                continue;
            }
            pDebri->y += 1;
            Show(pDebri);
            PollVsync();
        }
    }
}


void ScanDebris()
{
    ptr<byte> pUpperCell = MapPtr(0, ScanningRow);
    ptr<byte> pLowerCell = pUpperCell + MapWidth;
    repeat (8 / CoordRate) {
        byte column = 0;
        repeat (MapWidth) {
            byte upperByte = *pUpperCell; ++pUpperCell;
            byte lowerByte = *pLowerCell; ++pLowerCell;
            repeat (ColumnsPerByte) {
                byte upperCell = upperByte & 0x0f;
                if ((upperCell & Cell_Debri) != 0) {
                    byte lowerCell = lowerByte & 0x0f;
                    if ((lowerCell & Cell_Debri) == 0 && lowerCell != Cell_Floor) {
                        StartDebri(column << CellCoordShift, ScanningRow << CellCoordShift);
                        SetCell(column, ScanningRow, upperCell & ~Cell_Debri);
                    }
                }
                ++column;
                upperByte >>= 4;
                lowerByte >>= 4;
            }
        }
        ++ScanningRow;
        if (ScanningRow >= RowCount - 1) {
            ScanningRow = 0;
            pUpperCell = StageMap;
            pLowerCell = StageMap + MapWidth;
        }
        PollVsync();
    }
}