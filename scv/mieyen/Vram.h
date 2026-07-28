constexpr ptr<byte> VramOrg = (ptr<byte>)0x3000;
constexpr byte VramWidth = 32;
constexpr byte LeftOrgin = 3;
constexpr byte TopOrgin = 2;
constexpr ptr<byte> Vram = VramOrg + LeftOrgin + TopOrgin * VramWidth;

constexpr ptr<byte> PatternRam = (ptr<byte>)0x2000;

constexpr byte CharWidth = 8;
constexpr byte CharHeight = 8;
constexpr byte CharPatternSize = CharHeight;

constexpr byte SpriteWidth = 16;
constexpr byte SpriteHeight = 16;
constexpr byte SpritePatternSize = 2 * SpriteHeight;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pPattern, byte c);
extern ptr<byte> PrintC(ptr<byte> pPattern, byte c);
extern void ClearPattern(byte pattern);
extern void SetWall(byte x, byte y);

extern void TileSprites(byte index, byte x, byte y, byte pattern, byte count, byte color);