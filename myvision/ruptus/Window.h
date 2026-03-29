constexpr byte WindowWidth = 24;
constexpr byte WindowHeight = 24;

extern bool WindowChanged;
extern void ClearWindow();
extern ptr<byte> WindowPointer(byte x, byte y);
extern void Put1(sbyte x, sbyte y, byte c);
extern void Put6(sbyte x, sbyte y, byte c);