
struct EnemyBullet {
    byte x, y;
    byte sprite;
    sbyte dx, dy;
    byte clock;
    sbyte numeratorX, denominatorX;
    sbyte numeratorY, denominatorY;
};

extern void InitEnemyBullets();
extern bool StartEnemyBullet(byte x, byte y);
extern void MoveEnemyBullets();