#include "Main.h"
#include "ScanKeys.h"
#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Status.h"
#include "Stage.h"
#include "Actor.h"
#include "Monster.h"
#include "Lift.h"
#include "Man.h"
#include "Item.h"
#include "Point.h"

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);
constexpr byte BonusRate = 5;

word Score;
// word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte Clock;
sbyte monsterNum;

void Main()
{
    byte key, timeDenom;

    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
    StageTime = 0;
    
    title:
    Title();
    do {
        // if (ScanStop()) goto exit;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);
    
    play:
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;
    stage:
    InitStage();
    try:
    InitTrying();
    Clock = 0;
    monsterNum = 0;
    timeDenom = MaxTimeDenom;
    SwitchStatus(1);
    PresentVram();
    Sound_Start();     
    SwitchStatus(0);
    PresentVram();
    StartBGM();
    do {
    //     if (ScanStop()) goto exit;
        if ((Clock & 1) == 0) {
            FallMan();
            FallMonsters();
        }
        if ((Clock & 3) == 0) {
            UpdatePoints();
            MoveMan();
            if (monsterNum >= 0) {
                MoveMonsters();
                monsterNum -= 10;
            }
            monsterNum += 6;
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    PrintTimeUp();
                    lose:
                    StopBGM();
                    LooseMan();
                    --RemainCount;
                    if (RemainCount > 0) {
                        goto try;
                    } 
                    PrintGameOver();
                    Sound_GameOver();
                    goto title;
                }
            }
        }
        if ((Clock & 7) == 0) {
            MoveLifts();
            BlinkItems();
        }
        WaitTimer(1);
        PresentVram();
        ++Clock;
        if ((Man.status & Actor_Live) == 0) {
            goto lose;
        }
    } while (ItemCount != 0);
    WaitTimer(30);
    StopBGM();
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(1);
        StageTime -= BonusRate;
        PrintTime();
        PresentVram();
        Sound_Beep();
    }
    StageTime = 0;
    PrintStatus();
    ++CurrentStage;
    goto stage;
// exit:
//     Fin();
}


void AddScore(word pts) 
{
    Score += pts;
    // if (Score > HiScore) {
    //     HiScore = Score;
    // }
    PrintScore();
}