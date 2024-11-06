#include "Stage.h"
#include "Stages.h"
#include "Math.h"
#include "Fighter.h"
#include "FighterBullet.h"
#include "EnemyRow.h"
#include "MovingEnemy.h"
#include "Status.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"
#include "Team.h"
#include "EnemyBullet.h"
#include "Star.h"
#include "Bang.h"
#include "Item.h"

extern void _deb();

ptr<Stage> pStage;

void InitPlaying()
{
    RndIndex = 0;
    ClearScreen();
    InitBangs();
    InitItem();
    InitFighter();
    InitFighterBullets();
    InitEnemyBullets();
    InitStars();
    PrintStatus();
    // UpdateSprites();
    // InitEnemyRows();
    BackgroundChanged = true;
    DrawAll();
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
    InitMovingEnemies();
    InitEnemyRows();
    InitTeams();
    StartTeam();
    DrawAll();
}
