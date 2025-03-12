constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 28;

extern byte[] VVram;
extern bool VVramChanged;

extern ptr<byte> VVramPtr(byte x, byte y);
