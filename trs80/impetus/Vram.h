constexpr ptr<byte> VramOrg = (ptr<byte>)0x3c00;
constexpr byte VramWidth = 64;
constexpr byte VramHeight = 16;
constexpr word VramRowSize = VramWidth;
constexpr byte VramStep = 3;
constexpr ptr<byte> Vram = VramOrg + 2;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void VVramToVram();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void StatusToVram();
extern void EraseBackup();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
