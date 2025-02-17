#include "Stages.h"
#include "Vram.h"
#include "VVram.h"
#include "Math.h"
#include "Status.h"
#include "Sprite.h"
#include "Cannon.h"
#include "Bullet.h"
#include "Ufo.h"
#include "Bang.h"
#include "Block.h"
#include "Chars.h"

ptr<Stage> pStage;

void InitPlaying()
{
    RndIndex = 0;
    ClearScreen();
    PrintStatus();
    InitBullets();
    InitCannon();
    InitBlocks();
    InitBangs();
    ResetUfos();
    // UpdateSprites();
    BackgroundChanged = true;
}

void InitStage()
{
    {
        ptr<Stage> p;
        byte i, j;
        p = Stages;
        i = 0;
        j = 0;
        while (i < CurrentStage) {
            ++p;
            ++i;
            ++j;
            if (j >= StageCount) {
                p = Stages;
                j = 0;
            }
        }
        pStage = p;
    }
    InitUfos();
    ResetUfos();
}
