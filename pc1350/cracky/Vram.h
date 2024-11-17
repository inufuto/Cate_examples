constexpr ptr<byte> Vram00 = (ptr<byte>)0x7000;
constexpr ptr<byte> Vram01 = (ptr<byte>)0x7200;
constexpr ptr<byte> Vram02 = (ptr<byte>)0x7400;
constexpr ptr<byte> Vram03 = (ptr<byte>)0x7600;
constexpr ptr<byte> Vram04 = (ptr<byte>)0x7800;
constexpr ptr<byte> Vram10 = (ptr<byte>)0x7040;
constexpr ptr<byte> Vram11 = (ptr<byte>)0x7240;
constexpr ptr<byte> Vram12 = (ptr<byte>)0x7440;
constexpr ptr<byte> Vram13 = (ptr<byte>)0x7640;
constexpr ptr<byte> Vram14 = (ptr<byte>)0x7840;
constexpr ptr<byte> Vram20 = (ptr<byte>)0x701e;
constexpr ptr<byte> Vram21 = (ptr<byte>)0x721e;
constexpr ptr<byte> Vram22 = (ptr<byte>)0x741e;
constexpr ptr<byte> Vram23 = (ptr<byte>)0x761e;
constexpr ptr<byte> Vram24 = (ptr<byte>)0x781e;
constexpr ptr<byte> Vram30 = (ptr<byte>)0x705e;
constexpr ptr<byte> Vram31 = (ptr<byte>)0x725e;
constexpr ptr<byte> Vram32 = (ptr<byte>)0x745e;
constexpr ptr<byte> Vram33 = (ptr<byte>)0x765e;
constexpr ptr<byte> Vram34 = (ptr<byte>)0x785e;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
extern void VVramToVram();
extern ptr<byte> PrintC(ptr<byte> address, byte c);
extern ptr<byte> PutByte(ptr<byte> pVram, byte c);

extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
