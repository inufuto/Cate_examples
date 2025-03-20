constexpr byte CellType_Mask = 0x03;
constexpr byte CellType_Space = 0x00;
constexpr byte CellType_Ladder = 0x01;
constexpr byte CellType_Wall = 0x02;
constexpr byte CellType_Hole = 0x03;

constexpr byte ColumnCount = 16;
constexpr byte FloorHeight = 4;
constexpr byte FloorMask = FloorHeight - 1;
constexpr byte FloorShift = 2;
constexpr byte Overhead = FloorHeight - 3;
constexpr byte ColumnWidth = 2;
constexpr byte StageWidth = ColumnWidth * ColumnCount;

struct Stage {
    byte height;
    ptr<byte> pBytes;
    byte monsterCount;
    ptr<byte> pMonsters;
    byte blockCount;
    ptr<byte> pBlocks;
};

extern Stage[] Stages;
extern ptr<Stage> pStage;
extern byte[] StageMap;
extern byte topY, topRow, yMod, topYRange;
extern byte dotOffset;
extern byte[] Background;

extern void InitStage();
extern void FillBackground();
extern void InitTrying();
extern void DrawBackground();
extern byte GetCellType(byte x, byte y);
extern bool IsOnFloor(byte y);
extern bool IsWall(byte x, byte y);
extern byte ToX(byte b);
extern byte ToY(byte b);
