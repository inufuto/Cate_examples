extern byte[] VVram;
extern byte[] Backgnd;
extern byte[] RowFlags;

constexpr word Vram = 0x3000;
constexpr word Atributes = 0x2000;
constexpr byte VramWidth = 40;

extern void VVramToVram();
extern void BackgndToVVram();
extern void SetRowFlag2(byte y);
extern word PrintC(word address, byte c);
extern word PrintByteNumber3(word address, byte b);
extern word PrintByteNumber2(word address, byte b);
extern word PrintNumber5(word address, word w);
extern word PrintNumber3(word address, word w);

extern void Print2x2(word address, byte pattern);
extern void Erase2x2(word address);
extern void ClearScreen();
