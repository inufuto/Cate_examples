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
#include "Team.h"
#include "EnemyBullet.h"
#include "Star.h"
#include "Bang.h"
#include "Item.h"
#include "VVram.h"

extern void _deb();

ptr<Stage> pStage;

void InitPlaying()
{
    RndIndex = 0;
    HideAllSprites();
    ClearScreen();
    InitBangs();
    InitItem();
    InitFighter();
    InitEnemyRows();
    InitFighterBullets();
    InitEnemyBullets();
    InitStars();
    PrintStatus();
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
}
