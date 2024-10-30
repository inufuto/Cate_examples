constexpr ptr<byte> VVram = (ptr<byte>)0xe000;
constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 18;
constexpr byte WindowHeight = VVramHeight - 1;

extern bool BackgroundChanged;

extern void DrawBackground();
