#include "Movable.h"

constexpr byte ColumnCount = 16;
constexpr byte RowCount = 11;

constexpr byte ColumnWidth = 2;
constexpr byte RowHeight = 2;

constexpr byte GridShift = 1;

constexpr byte GridCoordShift = GridShift + CoordShift;
constexpr byte GridCoordRate = 1 << GridCoordShift;
constexpr byte GridCoordMask = GridCoordRate - 1;

constexpr byte ColumnsPerByte = 4;
constexpr byte MapSize = ColumnCount / ColumnsPerByte * RowCount;

constexpr byte Cell_Space = 0x0;
constexpr byte Cell_Wall = 0x1;
constexpr byte Cell_Box = 0x2;
constexpr byte Cell_Item = 0x3;

struct Stage {
    byte start;
    byte monsterCount;
    ptr<byte> pMonsters;
    byte ballCount;
    ptr<byte> pBalls;
    byte[MapSize] bytes;
};

extern ptr<Stage> pStage;
extern byte[] StageMap;
extern byte BoxCount;
extern byte TimerValue;

extern void SetCell(byte column, byte row, byte cell);
extern byte GetCell(byte column, byte row);
extern void DrawStage();

extern byte ToColumn(byte b);
extern byte ToRow(byte b);
extern void InitStage();
extern void SetCell(byte column, byte row, byte cell);
