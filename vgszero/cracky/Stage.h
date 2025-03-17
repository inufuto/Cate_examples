#include "Movable.h"

constexpr byte ColumnCount = 16;
constexpr byte FloorCount = 6;

constexpr byte ColumnsPerByte = 2;
constexpr byte ColumnWidth = 2;
constexpr byte FloorHeight = 4;

constexpr byte StageWidth = ColumnCount * ColumnWidth;
constexpr byte StageHeight = FloorCount * FloorHeight;

constexpr byte ColumnShift = 1;
constexpr byte ColumnMask = ColumnWidth - 1;
constexpr byte FloorShift = 2;
constexpr byte FloorMask = FloorHeight - 1;


constexpr byte Cell_Space = 0x0;
constexpr byte Cell_LowerMask = 0x3;
constexpr byte Cell_CrackedFloor = 0x1;
constexpr byte Cell_HardFloor = 0x3;
constexpr byte Cell_LadderDown = 0x2;
constexpr byte Cell_UpperMask = 0xc;
constexpr byte Cell_BrokenFloor = 0x4;
constexpr byte Cell_LadderUp = 0x8;
constexpr byte Cell_Item = 0xc;

struct Stage {
    byte start;
    byte itemCount;
    // ptr<byte> pItems;
    byte enemyCount;
    ptr<byte> pEnemies;
    byte[ColumnCount / ColumnsPerByte * FloorCount] bytes;
};

extern ptr<Stage> pStage;
extern ptr<byte> pStageBytes;
extern byte[] CellMap;

extern void InitStage();
extern void InitTrying();
extern byte GetCell(byte column, byte floor);
extern void SetCell(byte column, byte floor, byte cell);
extern void ShowStage();

extern ptr<byte> CellMapPtr(byte column, byte floor);
