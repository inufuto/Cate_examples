constexpr byte Man_Jump = 0x40;
constexpr byte Man_Fall = 0x20;

extern Actor Man;
extern byte PowerTime;

extern void ShowMan();
extern void InitMan();
extern void MoveMan();
extern void HitMan(ptr<Actor> pActor);
extern void FallMan();
extern void Scroll();
extern void LooseMan();
