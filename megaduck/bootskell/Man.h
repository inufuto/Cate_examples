extern Movable Man;
extern ptr<Movable> pMyBlock;

extern void InitMan();
extern void MoveMan();
extern bool IsNearMan(ptr<Movable> pMovable, byte x, byte y);
extern bool HitMan(ptr<Movable> pBlock);
extern void LooseMan();