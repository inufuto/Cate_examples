struct Fort {
    byte x, y;
    byte life;
};

extern Fort MyFort;
extern Fort EnemyFort;

extern void InitMyFort(byte position);
extern void InitEnemyFort(byte position);
extern void DrawForts();
extern bool HitMyFortR(byte x, byte y);
extern bool HitEnemyFortR(byte x, byte y);
extern bool HitMyFortB(byte x, byte y, byte width, byte height, byte side);
extern bool HitEnemyFortB(byte x, byte y, byte width, byte height, byte side);
