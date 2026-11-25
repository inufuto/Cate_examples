struct Lift {
    Movable _;
    byte x, bottom, top;
};

extern Lift[] Lifts;
extern byte LiftCount;

extern void InitLifts();
extern void MoveLifts();
extern bool IsOnAnyLift(ptr<Actor> pActor);