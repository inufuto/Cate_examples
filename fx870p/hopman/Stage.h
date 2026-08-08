#include "Movable.h"

constexpr byte StageTop = 2;

constexpr byte ColumnCount = 12 * 8;
constexpr byte FloorCount = 3;

constexpr byte ColumnsPerByte = 4;
constexpr byte ColumnWidth = 2;
constexpr byte FloorHeight = 4;

constexpr byte StageWidth = ColumnCount * ColumnWidth;
constexpr byte StageHeight = FloorCount * FloorHeight;

constexpr byte ColumnShift = 1;
constexpr byte ColumnMask = ColumnWidth - 1;
constexpr byte FloorShift = 2;
constexpr byte FloorMask = FloorHeight - 1;

constexpr byte Offset_Head = 1;
constexpr byte Offset_Foot = Offset_Head + 2;

constexpr byte Cell_Space = 0x0;
constexpr byte Cell_Floor = 0x1;
constexpr byte Cell_Item = 0x2;
constexpr byte Cell_Needle = 0x3;
constexpr byte Cell_Mask = 0x03;

struct Stage {
    byte itemCount;
    byte monsterCount;
    ptr<byte> pMonsters;
    byte liftCount;
    ptr<byte> pLifts;
    byte[ColumnCount / ColumnsPerByte * FloorCount] bytes;
};

extern ptr<Stage> pStage;
extern ptr<byte> pStageBytes;
extern byte[] CellMap;
extern byte LeftX;
extern bool Cleared;

extern void InitStage();
extern void InitTrying();
extern void Scroll();
extern byte GetCell(byte column, byte floor);
extern void SetCell(byte column, byte floor, byte cell);
extern byte XToColumn(byte x);
extern byte YToFloor(byte y);
extern byte FloorToY(byte floor);
extern byte ColumnToX(byte column);

extern ptr<byte> CellMapPtr(byte column, byte floor);
