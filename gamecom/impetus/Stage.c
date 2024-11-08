#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "VVram.h"
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

constexpr byte FortStartY = TileSize;//125;//
constexpr byte GroundWidth = VVramWidth / TileSize;
constexpr byte GroundHeight = (VVramHeight + TileSize * 2 - 1) / TileSize;

static ptr<Stage> pStage;
static word wMap;
static byte skyElementCount;
ptr<SkyElement> pSkyElement;
byte SkyElementBits;
byte groundElementCount;
ptr<GroundElement> pGroundElement;

static byte mapOffset;
byte topRow;
byte dotOffset;
bool GroundChanged;
byte[GroundWidth * GroundHeight] Ground;
sbyte GroundY;


static void FillTiles()
{
    CopyMapBytes(wMap);
    // CopyMemory(Ground, pMap, GroundWidth);
    GroundY = -TileSize;
}

static void RollDown()
{
    ptr<byte> pGround;
    pGround = Ground + GroundWidth * (GroundHeight - 1);
    repeat(GroundWidth * (GroundHeight - 1)) {
        --pGround;
        pGround[GroundWidth] = pGround[0];
    };
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
    wMap = (MapHeight - 1) * MapWidth + (word)mapOffset;
    topRow = MapHeight * TileSize;
    groundElementCount = pStage->groundElementCount;
    pGroundElement = pStage->pGroundElement;

    FillTiles();
    dotOffset = 0;
    VVramChanged = true;
    GroundChanged = true;
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

    FillMemory(Ground + GroundWidth, GroundWidth, 1);
    FillMemory(Ground + GroundWidth * 2, GroundWidth * (GroundHeight - 2), 12);
}


void ScrollGround()
{
    if (FortLife != 0) return;

    ScrollGroundEnemy();
    ++dotOffset;
    if (dotOffset == 8) {
        GroundChanged = true;
        dotOffset = 0;
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
            wMap -= MapWidth;
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
    VVramChanged = true;
}
