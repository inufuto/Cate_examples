constexpr byte MapWidth = 12;
constexpr byte MapHeight = 7;

constexpr byte StageWidth = MapWidth * 2;
constexpr byte StageHeight = MapHeight * 2;
// constexpr byte StageTop = 2;

constexpr byte Wall_None = 0;
constexpr byte Wall_Crack = 1;
constexpr byte Wall_Soft = 2;
constexpr byte Wall_Hard = 3;
constexpr byte Wall_MyRobo = 4;
constexpr byte Wall_MyFort = 5;
constexpr byte Wall_MyBullet = 6;
constexpr byte Wall_EnemyRobo = 7;
constexpr byte Wall_EnemyFort = 8;
constexpr byte Wall_EnemyBullet = 9;

struct Stage {
    byte myFort;
    byte enemyFort;
    byte[MapWidth / 4 * MapHeight] bytes;
};

extern void InitStage();
extern void InitTrying();
extern byte GetWall(byte x, byte y);
extern void SetWall(byte x, byte y, byte wall);
