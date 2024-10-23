#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Chars.h"
#include "CopyMemory.h"
#include "Fighter.h"
#include "FighterBullet.h"
#include "SkyEnemy.h"
#include "EnemyBullet.h"
#include "Bang.h"
#include "Math.h"
#include "Status.h"
#include "Barrier.h"
#include "GroundEnemy.h"
#include "Fort.h"
#include "Sprite.h"
#include "Item.h"

constexpr byte GroundHeight = VramHeight + TileSize;
constexpr byte ForestChar = Char_Terrain + 3;
constexpr byte FortStartY = TileSize;

byte[WindowWidth * GroundHeight] Ground;
static ptr<Stage> pStage;
static ptr<byte> pMap;
static byte skyElementCount;
ptr<SkyElement> pSkyElement;
byte SkyElementBits;
byte groundElementCount;
ptr<GroundElement> pGroundElement;

static byte mapOffset;
byte topRow;
byte charOffset, dotOffset;

void _deb(){}

static void FillTiles()
{
    byte row, column;
    ptr<byte> pSource, pGround;

    row = (topRow - 1) >> 2;

    pSource = pMap;
    pGround = Ground;
    for (column = 0; column < WindowWidth / TileSize; ++column) {
        ptr<Tile> pTile;
        ptr<byte> pSourceChar;
        
        pTile = &Tiles[*pSource];
        ++pSource;
        pSourceChar = pTile->chars;
        repeat (4) {
            repeat (4) {
                *pGround = *pSourceChar;
                ++pSourceChar;
                ++pGround;
            }
            pGround += WindowWidth - 4;
        }
        pGround += 4 - WindowWidth * 4;
    }
}


void InitStage() 
{
    byte i, j;
    i = 0;
    j = 0;
    pStage = Stages;
    while (i < CurrentStage) {
        ++pStage;
        ++i;
        ++j;
        if (j >= StageCount) {
            pStage = Stages;
            j = 0;
        }
    }

    mapOffset = pStage->mapOffset;
    skyElementCount = pStage->skyElementCount;
    pSkyElement = pStage->pSkyElements;
    pMap = MapBytes + (MapHeight - 1) * MapWidth + mapOffset;
    topRow = MapHeight * TileSize;
                                                    _deb();
    groundElementCount = pStage->groundElementCount;
    pGroundElement = pStage->pGroundElement;

    charOffset = 0;
    dotOffset = 0;

    RollChar();
    FillTiles();
    BackgroundChanged = true;
}

void InitTrying()
{
    SkyElementBits = 0;
    RndIndex = 0;

    HideAllSprites();
    InitFighter();
    InitFighterBullets();
    InitSkyEnemies();
    InitBarriers();
    InitGroundEnemies();
    InitFort();
    InitEnemyBullets();
    InitBangs();
    InitItem();

    FillMemory(Ground + WindowWidth * 4, WindowWidth, ForestChar - 1);
    FillMemory(Ground + WindowWidth * 5, WindowWidth * (GroundHeight - 4 - 1), ForestChar);
}


void ScrollGround()
{
    if (FortLife != 0) return;

    ++dotOffset;
    if (dotOffset == 8) {
        dotOffset = 0;
        RollDown();
        --topRow;
        if (topRow == FortStartY && FortLife == 0) {
            StartFort();
        }        
        if (topRow == 0) {
            ++CurrentStage;
            InitStage();
            PrintStage();
        }
        else if ((topRow & 3) == 0) {
            pMap -= MapWidth;
            FillTiles();
        }
        if (skyElementCount > 0 && pSkyElement->row >= topRow) {
            SkyElementBits = pSkyElement->bits;
            ++pSkyElement;
            --skyElementCount;
        }
        BackgroundChanged = true;
        StartSkyEnemy();
        StartGroundEnemy();
    }
    else {
        RollChar();
    }
    ScrollGroundEnemy();
}


// ptr<byte> GroundPtr(byte x, byte y)
// {
//     word w;
//     w = y;
//     return Ground + WindowWidth * TileSize + (w << 5) + x;
// }