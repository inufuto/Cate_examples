constexpr ptr<byte> Vram = (ptr<byte>)0x2000;

constexpr byte WindowWidth = 26;
constexpr byte WindowHeight = 24;

extern void VVramToVram();
extern void Locate(byte x, byte y);
extern void Put(byte c);
extern void PrintC(byte c);

extern void ClearScreen();
extern void Put2C(byte x, byte y, byte c);
extern void Erase2(byte x, byte y);
