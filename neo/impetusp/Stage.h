constexpr byte StageCount = 8;

constexpr byte MapWidth = 8;
constexpr byte MapHeight = 48;
constexpr byte TileSize = 4;

struct Tile {
    byte [16] chars0;
    byte [16] chars1;
    byte [16] chars2;
    byte [16] chars3;
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

extern void FillGround();
extern void RollDown();
extern void GroundToVVram();

extern void InitPlaying();
extern void ScrollGround();
