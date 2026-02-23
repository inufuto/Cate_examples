constexpr byte MapWidth = 16;
constexpr byte MapHeight = 11;

constexpr byte StageWidth = MapWidth * 2;
constexpr byte StageHeight = MapHeight * 2;
constexpr byte StageTop = 1;

constexpr byte Cell_Mask = 3;
constexpr byte Cell_None = 0;
constexpr byte Cell_Block = 1;
constexpr byte Cell_Wall = 2;

constexpr byte Cell_Man = 4;
constexpr byte Cell_MovingBlock = 5;
constexpr byte Cell_Monster = 6;

struct Stage {
    byte start;
    byte enemyCount;
    ptr<byte> pEnemies;
    byte[MapWidth / 4 * MapHeight] bytes;
};

extern ptr<Stage> pStage;

extern void InitStage();
extern void InitTrying();
extern byte GetCell(byte x, byte y);
extern void SetCell(byte x, byte y, byte wall);
