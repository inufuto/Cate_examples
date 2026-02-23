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

constexpr byte Cell_Down = 0x1;
constexpr byte Cell_Up = 0x2;
constexpr byte Cell_Block = 0x8;
constexpr byte Cell_Ceiling = 0x4; // upper cell (even row)
constexpr byte Cell_Item = 0x4; // lower cell (odd row)

constexpr byte StageWidth = ColumnCount * ColumnWidth;
constexpr byte StageHeight = FloorCount * FloorHeight;

constexpr byte ColumnsPerByte = 4;
struct Stage {
    byte start;
    byte blockCount;
    ptr<byte> pBlocks;
    byte enemyCount;
    ptr<byte> pEnemies;
    byte[ColumnCount / ColumnsPerByte * FloorCount] bytes;
};

extern ptr<Stage> pStage;
extern byte[] CellMap;
extern bool BackgroundChanged;

extern void InitStage();
extern void InitTrying();
extern byte GetCell(byte column, byte row);
extern void DrawCellCR(byte column, byte row);

extern ptr<byte> CellMapPtr(byte column, byte row);
