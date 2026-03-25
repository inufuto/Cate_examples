
struct EnemyBullet {
    byte x, y;
    sbyte dx, dy;
    byte sprite;
    byte clock;
    sbyte numeratorX, denominatorX;
    sbyte numeratorY, denominatorY;
};

extern void InitEnemyBullets();
extern bool StartEnemyBullet(byte x, byte y);
extern void MoveEnemyBullets();