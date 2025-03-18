constexpr byte VVramWidth = 30;
constexpr byte VVramHeight = 22;

constexpr byte WindowWidth = VVramWidth;
constexpr byte WindowHeight = VVramHeight - 1;

extern byte[] VVram;
extern bool BackgroundChanged;

extern void DrawBackground();
