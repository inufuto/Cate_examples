constexpr byte WindowWidth = 24;
constexpr byte WindowHeight = 24;
constexpr word WindowSize = WindowWidth * WindowHeight;

constexpr byte PcgBit = 0x08;

extern byte[WindowWidth * WindowHeight] WindowBack;
extern word[WindowWidth * WindowHeight] WindowFront;
extern bool WindowChanged;
extern byte[3] RowFlags;

extern void ClearWindowFront();
extern void ClearWindowBack();
extern void SetRowFlag(byte y);
extern void SetRowFlag2(byte y);
extern word WindowOffset(byte x, byte y);
extern void Put1(sbyte x, sbyte y, byte c);
extern void Put6(sbyte x, sbyte y, byte c);