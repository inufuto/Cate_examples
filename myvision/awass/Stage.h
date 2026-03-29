constexpr byte ColumnCount = 16;
constexpr byte FloorCount = 6;
constexpr byte RowCount = FloorCount * 2;

constexpr byte ColumnWidth = 2;
constexpr byte FloorHeight = 4;
constexpr byte RowHeight = FloorHeight / 2;
constexpr byte ColumnShift = 1;
constexpr byte FloorShift = 2;
constexpr byte RowShift = FloorShift - 1;

constexpr byte Cell_Blank = 0;
constexpr byte Cell_Floor = 1;
constexpr byte Cell_Ladder = 2;
constexpr byte Cell_Bomb = 3;
constexpr byte Cell_Flag = 4;
constexpr byte Cell_Mask = 7;

constexpr byte MaxFlagCount = 4 * 2;

struct Stage {
    byte start;
    byte monsterCount;
    ptr<byte> pMonsters;
    byte[MaxFlagCount] flags;
    byte[ColumnCount / 4 * FloorCount] bytes;
};

extern ptr<Stage> pStage;
extern byte[] StageMap;
extern sbyte Scrolling;
extern byte ScrollingFloor;
extern byte ScrollingClock;

extern ptr<byte> MapPtr(byte column, byte floor);
extern void DrawFloor(byte y, word vram, ptr<byte> pMap);
extern void DrawFloorShift(byte y, word vram, ptr<byte> pMap);
extern void RollRight(ptr<byte> pMap);
extern void RollLeft(ptr<byte> pMap);

extern byte ToColumn(byte b);
extern byte ToFloor(byte b);
extern void InitStage();
extern void InitTrying();
extern byte GetCell(byte column, byte row);
extern void MoveFloor();
extern void EraseBomb(byte column, byte floor);
