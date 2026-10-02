struct Monster {
    Movable _;
    byte targetX, targetY;
};


extern byte MonsterCount;
extern Monster[] Monsters;


extern void InitMonsters();
extern void StartMonsters();
extern void MoveMonsters();
extern bool IsNearMonster(ptr<Movable> pMovable, byte x, byte y);
extern bool HitMonster(ptr<Movable> pBlock);
