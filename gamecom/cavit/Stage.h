constexpr byte MapWidth = 12;
constexpr byte MapHeight = 8-1;

constexpr byte StageWidth = MapWidth * 2;
constexpr byte StageHeight = MapHeight * 2;

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

extern const byte[] WallBits;
extern byte[] TerrainMap;

extern byte CurrentTerrain(byte x, byte y);
// extern byte NextTerrain(byte x, byte y, byte direction);
extern void DrawTerrain(byte x, byte y, byte terrain);
extern void DrawTerrainBytes(byte x, byte y, ptr<byte> pChars);
extern void InitStage();
extern void InitTrying();

extern ptr<byte> TerrainMapPtr(byte x, byte y);
