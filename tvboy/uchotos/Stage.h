#include "Movable.h"

constexpr byte ColumnCount = 16;
constexpr byte FloorCount = 6;
constexpr byte RowCount = FloorCount * 2; 

constexpr byte CellSize = 2;
constexpr byte ColumnWidth = CellSize;
constexpr byte RowHeight = CellSize;
constexpr byte FloorHeight = RowHeight * 2;

constexpr byte CellShift = 1;
constexpr byte CellMask = ColumnWidth - 1;
constexpr byte CellCoordShift = CellShift + CoordShift;
constexpr byte CellCoordMask = CellSize * CoordRate - 1;

constexpr byte Source_Space = 0;
constexpr byte Source_Floor = 1;
constexpr byte Source_Ladder = 2;
constexpr byte Source_Item = 3;

constexpr byte Cell_Space = 0;
constexpr byte Cell_Floor = 1;
constexpr byte Cell_Ladder = 2;
constexpr byte Cell_Item = 3;
constexpr byte Cell_Debri = 0x0c;

struct Stage {
    byte start;
    byte enemyCount;
    ptr<byte> pEnemies;
    byte[ColumnCount / 4 * FloorCount] bytes;
};

constexpr byte ColumnsPerByte = 2;
constexpr byte MapWidth = (ColumnCount + ColumnsPerByte - 1) / ColumnsPerByte;

extern byte[] StageMap;
extern ptr<Stage> pStage;
extern byte ItemCount;

extern ptr<byte> MapPtr(byte column, byte row);
extern byte GetCell(byte column, byte row);
extern void SetCellBits(byte column, byte row, byte cell);

extern void InitStage();
extern void InitTrying();
extern void SetCell(byte column, byte row, byte cell);
extern void DrawCell(byte column, byte row, byte cell);