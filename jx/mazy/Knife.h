struct Knife {
    byte x, y;
    byte status;
    byte direction;
};

extern byte HeldKnifeCount;

extern void InitKnives();
extern void DrawKnives();
extern void MoveKnives();
extern void StartKnife(byte x, byte y, byte direction);
