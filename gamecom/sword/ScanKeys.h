constexpr byte Keys_Left = 0x01;
constexpr byte Keys_Right = 0x02;
constexpr byte Keys_DirX = Keys_Left | Keys_Right;
constexpr byte Keys_Up = 0x04;
constexpr byte Keys_Down = 0x08;
constexpr byte Keys_DirY = Keys_Up | Keys_Down;
constexpr byte Keys_Dir = Keys_DirX | Keys_DirY;
constexpr byte Keys_Button0 = 0x10;
constexpr byte Keys_Button1 = 0x20;

extern byte ScanKeys();
extern bool ScanStop();
extern byte ScanKeysWait();