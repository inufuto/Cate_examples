#include "Main.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Status.h"
#include "Stage.h"
#include "Man.h"
#include "Block.h"
#include "Monster.h"
#include "Math.h"
#include "Point.h"
#include "VVram.h"

// extern void Init();
// extern void Fin();
// extern void WaitTimer(byte t);
// extern void //PollVSync();
extern void Wait();

constexpr byte MaxTimeDenom = 50;
constexpr byte BonusRate = 9;

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte Clock;
sbyte monsterNum;

// extern void DrawAll();

void Main()
{
    byte key, timeDenom;

    // Init();
    // InitSprites(); 
    HiScore = 0;
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
    RndIndex = 0;
    timeDenom = MaxTimeDenom;
    Sound_Start();     
    // StartBGM();
    do {
        // if (ScanStop()) goto exit;
        if ((Clock & 3) == 0) {
            UpdatePoints();
            MoveMan();
            // WaitTimer(1);
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    PrintTimeUp();
                    lose:
                    // StopBGM();
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
            //PollVSync();     
            if (monsterNum >= 0) {
                MoveMonsters();
                monsterNum -= 10;
            }
            monsterNum += 6;
        }
        if ((Clock & 0x1f) == 0) {
            StartBlock();
        }
        //PollVSync();     
        UpdateBlocks();
        // UpdateSprites();
        if ((Clock & 0x03) == 0) {
            // WaitTimer(1);
            //PollVSync();        
            Wait();
            DrawAll();
            CallSound();
        }
        ++Clock;
        if ((Man.status & Movable_Live) == 0) {
            goto lose;
        }
    } while (MonsterCount != 0 || AnyBlockMoving());
    // WaitTimer(30);
    // StopBGM();
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(1);
        StageTime -= BonusRate;
        PrintTime();
        Sound_Beep();
        // WaitTimer(5);
        Wait();
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
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}