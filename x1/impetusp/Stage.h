constexpr byte StageCount = 8;

constexpr byte MapWidth = 8;
constexpr byte MapHeight = 48;
constexpr byte TileSize = 4;

struct Tile {
    byte [16] chars0;
    byte [16] chars4;
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
    ptr<byte> pBytes;
    byte skyElementCount;
    ptr<SkyElement> pSkyElements;
    byte groundElementCount;
    ptr<GroundElement> pGroundElement;
};

extern const Stage[] Stages;
extern ptr<Stage> pStage;
extern byte [] StageMap;
extern byte CurrentRow;
extern byte yMod;
extern byte DotOffset;

extern byte SkyElementBits;
extern byte GroundElementCount;
extern ptr<GroundElement> pGroundElement;

extern void DrawGround();
extern void RollDown();

extern void InitPlaying();
extern void ScrollGround();
