
constexpr word Vram = 0xc000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth;


extern byte[] VVram;
extern byte[] Backgnd;
extern byte[] RowFlags;

extern void SetRowFlag2(byte y);
extern word PrintByteNumber3(word vramAddress, byte b);
extern word PrintByteNumber2(word vramAddress, byte b);
extern word PrintNumber5(word vramAddress, word w);
extern word PrintNumber3(word vramAddress, word w);
extern void Print2x2(word vramAddress, byte c) ;
extern void Erase2x2(word vramAddress);
extern word PrintC(word vramAddress, byte c);

extern void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
extern void CopyMemeory(ptr<byte> pDestination, ptr<byte> pSource, word length);
extern void ClearScreen();
extern void VPut(word offset, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();
extern void BackgndToVVram();
