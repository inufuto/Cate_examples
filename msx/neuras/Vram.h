constexpr word VRAM_PatternGenerator = 0x0000;
constexpr word VRAM_PatternName = 0x1800;
constexpr word VRAM_ColorGenerator = 0x2000;

constexpr word Vram = VRAM_PatternName;

constexpr byte Vram_Width = 32;
constexpr byte Vram_Height = 24;

extern void InitVram();
extern void VErase2(byte x, byte y);
extern void VPut2(byte x, byte y, byte pattern);
extern word PrintC(word address, byte c);
extern byte ReadVram(word address);
extern void ClearScreen();
extern word PrintByteNumber3(word address, byte b);
extern word PrintByteNumber2(word address, byte b);
extern word PrintNumber5(word address, word w);
extern word PrintNumber3(word address, word w);
