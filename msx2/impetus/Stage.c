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

extern void _deb();

constexpr byte FortStartY = TileSize; //250;//
constexpr byte GroundWidth = VVramWidth / TileSize;
constexpr byte GroundHeight = (VVramHeight + TileSize * 2 - 1) / TileSize;
constexpr byte ForestChar = Char_Terrain + 3;

static ptr<Stage> pStage;
static ptr<byte> pMap;
static byte skyElementCount;
ptr<SkyElement> pSkyElement;
byte SkyElementBits;
byte groundElementCount;
ptr<GroundElement> pGroundElement;

static byte mapOffset;
byte topRow;
byte dotOffset;

byte[GroundWidth * GroundHeight] Ground;
sbyte GroundY;


static void FillTiles()
{
    CopyMemory(Ground, pMap, GroundWidth);
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
    GroundY = -TileSize;
    groundElementCount = pStage->groundElementCount;
    pGroundElement = pStage->pGroundElement;

    dotOffset = 0;

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

    FillMemory(Ground + GroundWidth, GroundWidth, 5);
    FillMemory(Ground + GroundWidth * 2, GroundWidth * (GroundHeight - 2), 12);
}


void ScrollGround()
{
    if (FortLife != 0) return;

    ScrollGroundEnemy();
    ++dotOffset;
    if (dotOffset == CoordRate) {
        dotOffset = 0;
        ++GroundY;
        --topRow;
        if (topRow == FortStartY && FortLife == 0) {
            StartFort();
        }        
        if (topRow == 0) {
            RollDown();
            ++CurrentStage;
            InitStage();
            PrintStage();
        }
        else if ((topRow & 3) == 0) {
            pMap -= MapWidth;
            RollDown();
            FillTiles();
            GroundY = -TileSize;
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
