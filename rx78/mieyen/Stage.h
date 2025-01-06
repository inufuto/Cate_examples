constexpr byte ColumnCount = 10;
constexpr byte RowCount = 7; 

constexpr byte CellSize = 3;
constexpr byte ColumnWidth = CellSize;
constexpr byte RowHeight = CellSize;

constexpr byte Cell_RightWall = 0x01;
constexpr byte Cell_BottomWall = 0x02;
constexpr byte Cell_Dot = 0x04;
constexpr byte Cell_Food = 0x08;

constexpr byte ColumnsPerByte = 2;
struct Stage {
    byte start;
    byte enemyCount;
    ptr<byte> pEnemies;
    byte[ColumnCount / ColumnsPerByte * RowCount] bytes;
};

extern ptr<Stage> pStage;
extern byte[] CellMap;

extern ptr<byte> CellMapPtr(byte column, byte row);
extern void DrawBackground();

extern void InitStage();
extern void InitTrying();
extern byte GetCell(byte column, byte row);
extern void SetCell(byte column, byte row, byte cell);
extern byte CoordMod(byte a);
extern byte ToGrid(byte a);
extern byte ToCoord(byte a);
