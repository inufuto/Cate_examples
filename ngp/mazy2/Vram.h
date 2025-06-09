constexpr word VramFrontOrg = 0x9000;
constexpr word VramBackOrg = 0x9800;

constexpr byte VramWidth = 32;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr word VramFront = VramFrontOrg + VramRowSize * 0;
constexpr word VramBack = VramBackOrg + VramRowSize * 0;

constexpr byte StatusHeight = 2;
constexpr byte VramHeight = 18;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern word Put(word vram, byte c);
extern byte ReadVram(word vram);

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern word Put2S(word vram, ptr<byte> pChars);
