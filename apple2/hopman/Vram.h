constexpr ptr<byte> Vram = (ptr<byte>)0x2000;

extern void ClearScreen();
extern void VVramToVram();
extern void Locate(byte x, byte y);
extern void Put(byte c);
extern void PrintC(byte c);

constexpr byte StatusHeight = 2;
constexpr byte WindowWidth = 32;

extern void Put2(byte x, byte y, byte c);
extern void Erase2(byte x, byte y);
