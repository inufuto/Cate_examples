#include "Stage.h"
#include "Main.h"
#include "Vram.h"
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

extern void _deb();

constexpr byte GroundHeight = (WindowHeight + TileSize - 1) / TileSize + 1;
constexpr byte BottomRow = MapHeight - 1;
constexpr byte FortStartY = 1;//30;//

ptr<Stage> pStage;
ptr<byte> pStageMap;
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
    pStageMap = pStage->pBytes;
    CurrentRow = MapHeight;
    pCurrentRow = pStageMap + MapWidth * MapHeight;

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
    FillMemory(Ground, MapWidth, 27);
    FillMemory(Ground + MapWidth, MapWidth * (GroundHeight - 1), 4);
    ClearScreen();
    PrintStatus();
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
    DrawGround();
    UpdateOffset();
    SwitchVram();
}


void ScrollGround()
{
    if (FortCount == 0) {
        DotOffset = (DotOffset + 1) & CoordMask;
        if (DotOffset == 0) {
            if (yMod == 0) {
                if (CurrentRow == FortStartY && FortCount == 0) {
                    StartForts();
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
                DrawGround();
                if (skyElementCount != 0 && pSkyElement->row >= CurrentRow) {
                    SkyElementBits = pSkyElement->bits;
                    ++pSkyElement;
                    --skyElementCount;
                }
            }
            yMod = (yMod - 1) & (TileSize - 1);
            StartSkyEnemy();
            StartGroundEnemy();
        }
        ScrollGroundEnemy();
    }
    UpdateOffset();
}
