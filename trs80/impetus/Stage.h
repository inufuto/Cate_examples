constexpr byte MapWidth = 24;
constexpr byte MapHeight = 32;

constexpr byte Terrain_Grass = 0;
constexpr byte Terrain_Sand = 1;
constexpr byte Terrain_Forest = 2;
constexpr byte Terrain_Water = 3;
constexpr byte Terrain_Concrete = 4;

struct Tile {
    byte [16] chars;
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

extern const Tile[] Tiles;
extern const byte[] MapBytes;
extern const Stage[] Stages;

extern byte SkyElementBits;
extern byte groundElementCount;
extern ptr<GroundElement> pGroundElement;

extern byte topRow;
extern byte[] Ground;

extern void InitStage();
extern void InitTrying();
extern void ScrollGround();
extern void DrawTiles();
