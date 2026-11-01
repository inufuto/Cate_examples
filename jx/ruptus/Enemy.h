struct Enemy {
    byte x, y;
    byte direction;
    byte sprite;
    sbyte numerator, denominator;
    byte bullttCount;
};

extern void InitEnemies();
extern byte Rnd();
extern void StartEnemy();
extern void MoveEnemy();
extern bool HitEnemy(byte x, byte y, byte size);
