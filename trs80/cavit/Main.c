#include "Main.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Status.h"
#include "Stage.h"
#include "Man.h"
#include "Chaser.h"
#include "Ghost.h"
#include "Rock.h"
#include "Point.h"
#include "Box.h"
#include "VVram.h"

extern void Wait(byte t);

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
    
    while (ScanKeys() != 0);
    title:
    Title();
    do {
        // if (ScanStop()) return;
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
    Sound_Start();     
    // StartBGM();
    do {
        // if (ScanStop()) return;
        
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
            Sound_GameOver();
            goto title;
        }
    } while (BoxCount != 0);
    DrawAll();
    // StopBGM();
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(3);
        StageTime -= BonusRate;
        PrintTime();
        Sound_Beep();
        // Wait(1);
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