constexpr word Vram = 0;

constexpr byte VramWidth = 24;
constexpr byte VramHeight = 17;
constexpr byte VramStep = 0x0001;
constexpr byte VramRowSize = 0x0100;

constexpr byte StatusHeight = 2;

extern void PresentVram();
extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern void DrawAll();
