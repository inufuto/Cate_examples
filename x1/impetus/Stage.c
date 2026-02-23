#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Chars.h"
#include "CopyMemory.h"
#include "VVram.h"
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
constexpr byte TerrainCharCount = (Char_End - Char_Terrain) / 2;
constexpr byte ForestChar = Char_Terrain + 7;
constexpr byte TopForestChar = Char_Terrain + 25;
constexpr byte FortStartY = TileSize;

static ptr<Stage> pStage;
static ptr<byte> pMap;
static byte skyElementCount;
ptr<SkyElement> pSkyElement;
byte SkyElementBits;
byte groundElementCount;
ptr<GroundElement> pGroundElement;

static byte mapOffset;
byte topRow;
byte charOffset;


static void FillTiles()
{
    byte row, column;
    ptr<byte> pSource, pGround;

    row = (topRow - 1) >> 2;

    pSource = pMap;
    pGround = Ground;
    for (column = 0; column < VVramWidth / TileSize; ++column) {
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
            pGround += VVramWidth - 4;
        }
        pGround += 4 - VVramWidth * 4;
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
    groundElementCount = pStage->groundElementCount;
    pGroundElement = pStage->pGroundElement;

    charOffset = 0;

    FillTiles();
    VVramChanged = true;
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

    FillMemory(VVramBack, VVramWidth, TopForestChar);
    FillMemory(VVramBack + VVramWidth, VVramWidth * (VVramHeight - 1), ForestChar);
}


void ScrollGround()
{
    if (FortLife != 0) return;

    ScrollGroundEnemy();
    charOffset ^= TerrainCharCount;
    if (charOffset == 0) {
        RollDown();
        --topRow;
        if (topRow == FortStartY && FortLife == 0) {
            StartFort();
        }        
        if (topRow == 0) {
            ++CurrentStage;
            InitStage();
            PrintStage();
            // StatusToVVram();
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
        StartSkyEnemy();
        StartGroundEnemy();
    }
    VVramChanged = true;
}
