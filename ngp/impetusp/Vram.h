constexpr word VramFrontOrg = 0x9000;
constexpr word VramBackOrg = 0x9800;

constexpr byte VramWidth = 32;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr word VramFront = VramFrontOrg + VramRowSize * 0;
constexpr word VramBack = VramBackOrg + VramRowSize * 0;

constexpr byte WindowWidth = 20;
constexpr byte WindowHeight = 19;
constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void SwitchVram();
