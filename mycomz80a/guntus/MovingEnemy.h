constexpr byte MovingEnemy_None = 0;
constexpr byte MovingEnemy_StandBy = 1;
constexpr byte MovingEnemy_Sally = 2;
constexpr byte MovingEnemy_Align = 3;
constexpr byte MovingEnemy_Turn = 4;
constexpr byte MovingEnemy_Attack = 5;
constexpr byte MovingEnemy_Return = 6;

struct MovingEnemy {
    byte status;
    byte x, y;
    byte sprite;
    byte type;
    sbyte dx, dy;
    byte direction;
    byte target;
    byte bulletCount;
};

extern MovingEnemy[] MovingEnemies;
extern byte FreeEnemyCount;

extern void InitMovingEnemies();
extern ptr<MovingEnemy> StartMovingEnemy(byte status, byte type);
extern void ShowMovingEnemy(ptr<MovingEnemy> pEnemy);
extern void SetMovingEnemyDirection(ptr<MovingEnemy> pEnemy, byte direction);
extern void MoveMovingEnemies();
extern bool HitBulletMovingEnemy(byte x, byte y);
