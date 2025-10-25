constexpr word Vram0 = 0x3000;
constexpr word Vram1 = 0x3400;
constexpr word Attributes = 0x2000;
constexpr word GVram = 0x4000;
constexpr word Vram = Vram0;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr word VramRowSize = VramWidth;
constexpr byte VramStep = 1;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern word WriteVram(word vram, byte c);
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void EraseSprite(byte x, byte y);
extern void DrawSprite1(byte x, byte y, byte pattern);
extern void DrawSprite2(byte x, byte y, byte pattern);
extern void SwitchVram();
extern void VVramToVram();

extern void DrawAll();

extern void PollVSync();