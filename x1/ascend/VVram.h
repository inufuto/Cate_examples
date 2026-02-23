constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;

constexpr byte WindowWidth = VVramWidth;
constexpr byte WindowHeight = VVramHeight;

extern byte[] VVramFront, VVramBack;

extern word VVramOffset(byte x, byte y);
extern void MapToBackGround();
extern void EraseFront();

extern void DrawAll();
