#include "Main.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "Vram.h"
// #include "Sound.h"
#include "Status.h"
#include "Stage.h"
#include "Man.h"
#include "Chaser.h"
#include "Ghost.h"
#include "Rock.h"
#include "Point.h"
#include "Box.h"
#include "VVram.h"

constexpr byte MaxTimeDenom = 50;
constexpr byte BonusRate = 3;

word Score;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte Clock;
sbyte monsterNum;


void Main()
{
    static byte key, timeDenom;

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
    Clock = 0;
    monsterNum = 0;
    timeDenom = MaxTimeDenom;
    InitTrying();
    // UpdateSprites();
    DrawAll();
    // Sound_Start();     
    Wait(100);  
    // StartBGM();
    do {
        // if (ScanStop()) goto exit;
        
        if ((Clock & 0x03) == 0) {
            UpdatePoints();
            
            MoveMan();
            
            TestRocks();
            
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    // StopBGM();
                    PrintTimeUp();
                    LooseMan();
                    goto lose;
                }
            }
            if (monsterNum >= 0) {
                MoveChasers();
                
                MoveGhosts();
                
                monsterNum -= 4;
            }
            monsterNum += 3;
        }
        MoveRocks();
        // UpdateSprites();
        if ((Clock & 0x07) == 0) {
            Wait(2);
            DrawAll();
        }
        
        ++Clock;
        if ((man.status & Movable_Status_Live) == 0) {
            // StopBGM();
            LooseMan();
            lose:
            --RemainCount;
            if (RemainCount > 0) {
                goto try;
            } 
            PrintGameOver();
            // Sound_GameOver();
            Wait(200);
            goto title;
        }
    } while (BoxCount != 0);
    DrawAll();
    // StopBGM();
    // Sound_Clear();
    Wait(150);
    while (StageTime >= BonusRate) {
        AddScore(3);
        StageTime -= BonusRate;
        PrintTime();
        // PresendVram();
        // Sound_Beep();
        Wait(3);
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
    PrintScore();
}