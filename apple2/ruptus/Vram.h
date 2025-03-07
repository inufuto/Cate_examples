// constexpr byte VramWidth = 40;
// constexpr byte VramHeight = 25;
// constexpr byte CharHeight = 8;

constexpr ptr<byte> Vram = (ptr<byte>)0x2000;
// constexpr ptr<byte> VramLeftTop = Vram + (VramWidth - 32) / 2;

extern void WindowToVramAll();
extern void WindowToVramChanged();
extern void VLocate(byte x, byte y);
extern void VPut1(byte c);
extern void PrintC(byte c);
// extern void PlotMarker(ptr<byte> pVram, word bytes);

extern void ClearScreen();
extern void VPut2(byte x, byte y, byte c);
extern void VErase2(byte x, byte y);
extern void VPut4(byte x, byte y, ptr<byte> pBytes);
extern void PlotMarker(byte x, byte y, byte xMod, byte yMod);