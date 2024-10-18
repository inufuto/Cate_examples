constexpr ptr<byte> Vram = ((ptr<byte>)0x9800);
constexpr byte VramWidth = 32;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr byte VramHeight = 18;

constexpr byte StatusHeight = 2;
constexpr byte WindowWidth = 20;
constexpr byte WindowHeight = 18 - StatusHeight;

extern bool BackgroundChanged;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> CurrentPage();
extern ptr<byte> NextPage();
extern void SwitchPage();
extern ptr<byte> WriteVram(ptr<byte> pVram, byte c);
extern void DrawBackground(ptr<byte> pVram);

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
extern void DrawAll();