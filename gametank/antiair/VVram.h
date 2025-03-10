constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 23;

constexpr byte WindowWidth = VVramWidth;
constexpr byte WindowHeight = VVramHeight - 1;

extern byte[] VVram;
extern bool BackgroundChanged;

extern void DrawBackground();

extern void DrawGround();