struct SkyEnemy {
    byte x, y;
    sbyte dx, dy;
    byte sprite, pattern;
    byte type, direction;
    byte clock;
    byte bulletCount;
};

extern SkyEnemy[] SkyEnemies;

extern void InitSkyEnemies();
extern void StartSkyEnemy();
extern void MoveSkyEnemies();
extern bool HitBulletSkyEnemy(byte x, byte y);
