constexpr byte WindowWidth = 24;
constexpr byte WindowHeight = 24;
constexpr word WindowSize = WindowWidth * WindowHeight;

extern byte[WindowWidth * WindowHeight] WindowBack;
extern byte[WindowWidth * WindowHeight] WindowFront;
extern bool WindowChanged;
extern byte[3] RowFlags;

extern void ClearWindow();
extern void WindowBackToFront();
extern word WindowOffset(byte x, byte y);
extern void Put1(sbyte x, sbyte y, byte c);
extern void Put6(sbyte x, sbyte y, byte c);