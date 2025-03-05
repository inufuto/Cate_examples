constexpr ptr<byte> Vram = (ptr<byte>)0x2000;

extern void VVramToVramAll();
extern void VVramToVramChanged();
extern void VLocate(byte x, byte y);
extern void VPut1(byte c);
extern void PrintC(byte c);

extern void ClearScreen();
extern void VPut2(byte x, byte y, byte c);
extern void VErase2(byte x, byte y);
