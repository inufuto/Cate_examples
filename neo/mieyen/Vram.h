constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;

constexpr byte StageTop = 1;

extern void ClearScreen();
extern byte Put(byte x, byte y, byte c);

extern byte PrintC(byte x, byte y, byte c);
extern byte Put2C(byte x, byte y, byte c);
extern byte Erase2(byte x, byte y);
