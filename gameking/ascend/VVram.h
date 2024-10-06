constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16 - 2;

extern byte[] VVram;
extern bool BackgroundChanged;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void MapToVVram();

extern void DrawAll();
// extern void VPut2C(ptr<byte> pVVram, byte c);
// extern void VPut2S(ptr<byte> pVVram, ptr<byte> pChars);
// extern void VErase2(ptr<byte> pVVram);
