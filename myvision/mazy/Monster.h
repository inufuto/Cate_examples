struct Monster {
    byte x, y;
    byte type;
    byte status;
    byte clock;
};

extern void InitMonsters();
extern void DrawMonsters();
extern void MoveMonsters();
extern bool MonsterHitKnife(byte kx, byte ky);
