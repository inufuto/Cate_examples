#include "VVram.h"

constexpr byte MapWidth = VVramWidth / 2;
constexpr byte MapHeight = VVramHeight / 2;

constexpr byte StageWidth = MapWidth * 2;
constexpr byte StageHeight = MapHeight * 2;
constexpr byte StageTop = 2;

constexpr byte Line_Left = 0x01;
constexpr byte Line_Right = 0x02;
constexpr byte Line_Top = 0x04;
constexpr byte Line_Bottom = 0x08;
constexpr byte Cell_Line = Line_Left | Line_Right | Line_Top | Line_Bottom;
constexpr byte Cell_Space = 0x00;
constexpr byte Cell_Wall = 0x10;
constexpr byte Cell_Item = 0x20;
constexpr byte Cell_Mask = 0xf0;

struct Stage {
    byte start;
    byte itemCount;
    ptr<byte> pItems;
    byte enemyCount;
    ptr<byte> pEnemies;
    byte[MapWidth / 4 * MapHeight] bytes;
};

extern ptr<Stage> pStage;

extern void InitStage();
extern void InitTrying();
extern ptr<byte> CellMapPtr(byte x, byte y);
extern byte GetCell(byte x, byte y);
// extern void SetCell(byte x, byte y, byte wall);
