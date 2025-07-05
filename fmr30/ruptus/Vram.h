constexpr word Vram = 0x0000;

constexpr byte VramWidth = 80;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth * 16;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();
extern void SwitchVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);
extern word VramAddress(byte x, byte y);

extern void DrawAll();
extern word PrintC(word vram, byte c);
extern void Put2C(word vram, byte c);
extern void Erase2(word vram);
extern void Put4C(word vram, ptr<byte> pBytes);
