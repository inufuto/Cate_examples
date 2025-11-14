#include "Stage.h"
#include "Main.h"
#include "VVram.h"
#include "Math.h"
#include "CopyMemory.h"
#include "Movable.h"
#include "Status.h"
#include "Sprite.h"
#include "Fighter.h"
#include "SkyEnemy.h"
#include "GroundEnemy.h"
#include "FighterBullet.h"
#include "EnemyBullet.h"
#include "Barrier.h"
#include "Bang.h"
#include "Fort.h"
#include "Item.h"
#include "Vram.h"

extern void _deb();

constexpr byte GroundHeight = VVramHeight / TileSize + 1;
constexpr byte BottomRow = MapHeight - 1;
constexpr byte FortStartY = 1;//46;//

ptr<Stage> pStage;
byte [MapWidth * MapHeight] StageMap;
byte [MapWidth * GroundHeight] Ground;
ptr<byte> pCurrentRow;
byte CurrentRow;
byte yMod;
byte DotOffset;

static byte skyElementCount;
static ptr<SkyElement> pSkyElement;
byte SkyElementBits;

byte GroundElementCount;
ptr<GroundElement> pGroundElement;

static void InitStage()
{
    {
        byte i = 0;
        byte j = 0;
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
    }
    {
        ptr<byte> pBytes = pStage->pBytes;
        ptr<byte> pMap = StageMap;
        do {
            byte b = *pBytes; ++pBytes;
            if ((b & 0x80) != 0) {
                byte count = b & 0x7f;
                b = *pBytes; ++pBytes;
                do {
                    *pMap = b; ++pMap;
                    --count;
                } while (count != 0);
            }
            else {
                *pMap = b; ++pMap;
            }
        } while (pMap < StageMap + MapWidth * MapHeight);
    }
    CurrentRow = MapHeight;
    pCurrentRow = StageMap + MapWidth * MapHeight;

    skyElementCount = pStage->skyElementCount;
    pSkyElement = pStage->pSkyElements;
    GroundElementCount = pStage->groundElementCount;
    pGroundElement = pStage->pGroundElement;
}


void InitPlaying()
{
    SkyElementBits = 0;
    RndIndex = 0;
    InitStage();
    FillMemory(Ground, MapWidth, 24);
    FillMemory(Ground + MapWidth, MapWidth * (GroundHeight - 1), 0);
    FillGround();
    ClearScreen();
    PrintStatus();
    BackgroundChanged = true;
    yMod = TileSize - 1;
    DotOffset = -1;
    HideAllSprites();
    InitFighter();
    InitFighterBullets();
    InitEnemyBullets();
    InitSkyEnemies();
    InitBarriers();
    InitGroundEnemies();
    InitForts();
    InitBangs();
    InitItem();
    ScrollGround();
    DrawAll();
}


void ScrollGround()
{
    if (FortCount != 0) return;

    DotOffset = (DotOffset + 1) & CoordMask;
    if (DotOffset == 0) {
        bool fortStarted = false;
        if (yMod == 0) {
            if (CurrentRow == FortStartY && FortCount == 0) {
                StartForts();
                fortStarted = true;
            }        
            --CurrentRow;
            if (CurrentRow >= MapHeight) {
                ++CurrentStage;
                PrintStage();
                InitStage();
                --CurrentRow;
            }
            pCurrentRow -= MapWidth;
            RollDown();
            FillGround();
            if (skyElementCount != 0 && pSkyElement->row >= CurrentRow) {
                SkyElementBits = pSkyElement->bits;
                ++pSkyElement;
                --skyElementCount;
            }
        }
        yMod = (yMod - 1) & (TileSize - 1);
        BackgroundChanged = true;
        // if (fortStarted) {
        //     UpdateGroundChars(true);
        // }
        StartSkyEnemy();
        StartGroundEnemy();
    }
    else {
        UpdateGroundChars(false);
    }
    ScrollGroundEnemy();
}
