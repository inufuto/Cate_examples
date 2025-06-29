#include "VVram.h"

constexpr byte TileWidth = 2;
constexpr byte TileHeight = 2;
constexpr byte MapWidth = 64;
constexpr byte StageWidth = VVramWidth;
constexpr byte StageHeight = 22;

struct SkyElement {
    byte x;
    byte bits;
};

struct GroundElement {
    byte x;
    byte type;
};

struct Stage {
    byte[MapWidth / 4] bytes;
    byte skyElementCount;
    ptr<SkyElement> pSkyElements;
    byte groundElementCount;
    ptr<GroundElement> pGroundElements;
};

extern byte MinGroundY;

extern void InitStage();
extern void InitGame();
extern void ScrollBackground();
extern byte GroundY(byte x);
