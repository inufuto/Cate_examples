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
#include "Print.h"

// constexpr byte TerrainCharCount = (Char_End - Char_Terrain) / 2;
constexpr byte FortStartY = TileSize;
constexpr byte GroundWidth = VVramWidth / TileSize;
constexpr byte GroundHeight = (VVramHeight + TileSize * 2 - 1) / TileSize;

static ptr<Stage> pStage;
static ptr<byte> pMap;
static byte skyElementCount;
ptr<SkyElement> pSkyElement;
byte SkyElementBits;
byte groundElementCount;
ptr<GroundElement> pGroundElement;

static byte mapOffset;
byte topRow;

byte[GroundWidth * GroundHeight] Ground;
sbyte GroundY;

void _deb(){}

static void FillTiles()
{
    CopyMemory(Ground, pMap, GroundWidth);
    GroundY = -TileSize;
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

    FillTiles();
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
    // FillMemory(Ground + GroundWidth, GroundWidth, 0);
    FillMemory(Ground + GroundWidth * 1, GroundWidth * (GroundHeight - 1), 1);
}


void ScrollGround()
{
    if (FortLife != 0) return;

    ScrollGroundEnemy();

    ++GroundY;
    --topRow;
    if (topRow == FortStartY && FortLife == 0) {
        StartFort();
    }        
    if (topRow == 0) {
        ++CurrentStage;
        RollDown();
        InitStage();
        PrintStage();
    }
    else if ((topRow & 3) == 0) {
        pMap -= MapWidth;
        RollDown();
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
