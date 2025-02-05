constexpr byte MapWidth = 16;
constexpr byte MapHeight = 11;

constexpr byte StageWidth = MapWidth * 2;
constexpr byte StageHeight = MapHeight * 2;
// constexpr byte StageTop = 2;

constexpr byte Terrain_Space = 0;
constexpr byte Terrain_Soil = 1;
constexpr byte Terrain_Wall = 2;
constexpr byte Terrain_Rock = 4;
constexpr byte Terrain_Mask = 0x0f;
constexpr byte Wall_Left = 0x10;
constexpr byte Wall_Right = 0x20;
constexpr byte Wall_Top = 0x40;
constexpr byte Wall_Bottom = 0x80;
constexpr byte Wall_All = 0xf0;

constexpr byte Char_Soil0 = 0xb9;
constexpr byte Char_Soil1 = 0x4f;
constexpr byte Char_Bedrock = 0x5a;
constexpr byte Char_Wall_Space = 0x00;
constexpr byte Char_Wall_Left = 0x71;
constexpr byte Char_Wall_Right = 0x3d;
constexpr byte Char_Wall_Top = 0x70;
constexpr byte Char_Wall_Bottom = 0x3c;
constexpr byte Char_Wall_RightTop = 0x73;
constexpr byte Char_Wall_RightBottom = 0x33;
constexpr byte Char_Wall_LeftTop = 0x72;
constexpr byte Char_Wall_LeftBottom = 0x32;

extern const byte[] WallBits;
extern byte[] TerrainMap;

extern ptr<byte> TerrainMapPtr(byte x, byte y);
extern byte CurrentTerrain(byte x, byte y);
// extern byte NextTerrain(byte x, byte y, byte direction);
extern void DrawTerrain(byte x, byte y, byte terrain);
extern void DrawTerrainBytes(byte x, byte y, ptr<byte> pChars);
extern void InitStage();
extern void InitTrying();
