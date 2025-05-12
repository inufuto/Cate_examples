constexpr byte ColumnCount = 10;
constexpr byte RowCount = 7;

constexpr byte CellSize = 3;
constexpr byte ColumnWidth = CellSize;
constexpr byte RowHeight = CellSize;

constexpr byte Cell_RightWall = 0x01;
constexpr byte Cell_BottomWall = 0x02;
constexpr byte Cell_LeftWall = 0x10;
constexpr byte Cell_TopWall = 0x20;
constexpr byte Cell_DownStair = 0x04;
constexpr byte Cell_UpStair = 0x08;
constexpr byte Cell_Goal = 0x0c;
constexpr byte Cell_TypeMask = 0x0c;
constexpr byte Cell_NextScan = 0x40;
constexpr byte Cell_Visible = 0x80;

struct Floor {
    byte[3 * RowCount] bytes;
    byte stairCount;
    ptr<byte> pStairs;
    byte monsterCount;
    ptr<byte> pMonsters;
    byte knifeCount;
    ptr<byte> pKnives;
};

struct Stage {
    byte floorCount;
    ptr<Floor> pFloors;
    byte start;
    byte goal;
};

extern ptr<Stage> pStage;
extern byte[] CellMap;
extern byte CurrentFloor;
extern byte GoalX, GoalY;
extern bool Reached;

extern ptr<byte> CellMapPtr(byte column, byte row);
extern void MapToVVram();

extern byte CoordMod(byte a);
extern byte ToGrid(byte a);
extern byte ToCoord(byte a);
extern void InitStage();
extern void InitTrying();
extern void InitFloor();
extern void ChangeFloor(byte floor);
