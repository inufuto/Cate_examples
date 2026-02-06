constexpr byte MaxMapWidth = 64;
constexpr byte MaxMapHeight = 64;
constexpr byte MapStep = MaxMapWidth / 8;
constexpr byte MapSize = MapStep * MaxMapHeight;

extern byte StageWidth, StageHeight;
extern byte MapWidth, MapHeight;
extern byte BaseX, BaseY;
extern byte GoalX, GoalY;
extern ptr<byte> pStage;

extern byte ToMapSize(byte a);
extern void InitMap();
extern void DrawGoal();
extern bool CanMove1(byte x, byte y);
extern bool CanMove2(byte x, byte y);
