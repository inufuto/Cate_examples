constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr word VramRowSize = VramWidth * CharHeight;
constexpr byte StatusHeight = 2;

constexpr ptr<byte> Vram = (ptr<byte>)0x6000;

extern byte[] VVram;
extern byte[] Backgnd;
extern byte[] RowFlags;

extern void VVramToVram();
extern void BackgndToVVram();
extern void SetRowFlag2(byte y);
extern ptr<byte> PrintC(ptr<byte> address, byte c);
extern ptr<byte> PrintByteNumber3(ptr<byte> address, byte b);
extern ptr<byte> PrintByteNumber2(ptr<byte> address, byte b);
extern ptr<byte> PrintNumber5(ptr<byte> address, word w);
extern ptr<byte> PrintNumber3(ptr<byte> address, word w);

extern void Print2x2(ptr<byte> address, byte pattern);
extern void Erase2x2(ptr<byte> address);
extern void ClearScreen();
