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

constexpr byte FortStartY = TileSize;//250;//
constexpr byte GroundWidth = StageWidth / TileSize;
constexpr byte GroundHeight = (StageHeight + TileSize * 2 - 1) / TileSize;

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
byte[GroundWidth * GroundHeight] Ground;
sbyte GroundY;


static void FillTiles()
{
    CopyMemory(Ground, pMap, GroundWidth);
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
    pMap = MapBytes + (MapHeight - 1) * MapWidth + mapOffset;
    topRow = MapHeight * TileSize;
    groundElementCount = pStage->groundElementCount;
    pGroundElement = pStage->pGroundElement;

    FillTiles();
    charOffset = 0;
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

    FillMemory(Ground + GroundWidth, GroundWidth, 5);
    FillMemory(Ground + GroundWidth * 2, GroundWidth * (GroundHeight - 2), 12);
    BackgroundChanged = true;
}


void ScrollGround()
{
    if (FortLife != 0) return;

    ScrollGroundEnemy();
    charOffset ^= TileSize * TileSize;
    if (charOffset == 0) {
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
    BackgroundChanged = true;
}
