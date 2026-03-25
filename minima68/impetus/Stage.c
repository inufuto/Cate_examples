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

constexpr byte GroundHeight = StageHeight + TileSize;
constexpr byte FortStartY = TileSize;//250;//

byte[StageWidth * GroundHeight] Ground;
static ptr<Stage> pStage;
static ptr<byte> pMap;
static byte skyElementCount;
ptr<SkyElement> pSkyElement;
byte SkyElementBits;
byte groundElementCount;
ptr<GroundElement> pGroundElement;

static byte mapOffset;
byte topRow;
byte GroundCharOffset, GroundOffset;

static void FillTiles()
{
    byte row, column;
    ptr<byte> pSource, pGround;

    row = (topRow - 1) >> 2;

    pSource = pMap;
    pGround = Ground;
    for (column = 0; column < StageWidth / TileSize; ++column) {
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
            pGround += StageWidth - 4;
        }
        pGround += 4 - StageWidth * 4;
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

    GroundCharOffset = 0;
    GroundOffset = 0;

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

    FillMemory(Ground + StageWidth * 4, StageWidth, Char_Terrain + 3);
    FillMemory(Ground + StageWidth * 5, StageWidth * (GroundHeight - 4 - 1), Char_Terrain + 13);
}


void ScrollGround()
{
    if (FortLife != 0) return;

    ScrollGroundEnemy();
    ++GroundOffset;
    if (GroundOffset == CoordRate) {
        GroundOffset = 0;
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
        StartSkyEnemy();
        StartGroundEnemy();
        BackgroundChanged = true;
    }
    else {
        UpdateGroundChars();
    }
}
