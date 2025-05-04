constexpr byte VramCharWidth = 80;
constexpr byte VramAttrWidth = 40;
constexpr byte VramWidth = VramCharWidth + VramAttrWidth;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 2;
constexpr word VramRowSize = VramWidth;

struct VramAttr {
    byte column;
    byte attr;
};

struct VramRow {
    byte[VramCharWidth] chars;
    VramAttr[VramAttrWidth / 2] attrs;
};

constexpr ptr<VramRow> Vram = (ptr<VramRow>)0xf300;

extern void VVramToVram();
extern void ClearScreen();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
