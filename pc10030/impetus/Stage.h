constexpr byte MapWidth = 32;
constexpr byte MapHeight = 64;
// constexpr byte StageWidth = 32;
// constexpr byte StageHeight = 24;
constexpr byte TileSize = 4;

constexpr byte Terrain_Grass = 0;
constexpr byte Terrain_Sand = 1;
constexpr byte Terrain_Forest = 2;
constexpr byte Terrain_Water = 3;
constexpr byte Terrain_Concrete = 4;

struct Tile {
    byte [16] chars0;
    byte [16] chars1;
    // byte [16] chars2;
    // byte [16] chars3;
    // byte [16] chars4;
    // byte [16] chars5;
    // byte [16] chars6;
    // byte [16] chars7;
};

struct Position {
    byte x, y;
};

struct SkyElement {
    byte row;
    byte bits;
};

struct Route {
    sbyte dx, dy;
    byte count;
};

struct GroundElement {
    byte x, y;
    byte routeCount;
    ptr<Route> pRoute;
};

struct Stage {
    byte mapOffset;
    byte skyElementCount;
    ptr<SkyElement> pSkyElements;
    byte groundElementCount;
    ptr<GroundElement> pGroundElement;
};

extern Tile[] Tiles;
extern byte[] MapBytes;
extern Stage[] Stages;

extern byte[] Ground;
extern byte SkyElementBits;
extern byte groundElementCount;
extern ptr<GroundElement> pGroundElement;

extern byte topRow;
extern byte dotOffset;

extern void InitStage();
extern void InitTrying();
extern void ScrollGround();
