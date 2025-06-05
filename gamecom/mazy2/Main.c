#include "Main.h"
#include "Vram.h"
#include "Chars.h"
#include "Status.h"
#include "ScanKeys.h"
#include "Stage.h"
#include "Sound.h"
#include "Sprite.h"
#include "Man.h"
#include "Monster.h"
#include "Knife.h"
#include "Point.h"

extern void WaitTimer(byte t);

constexpr byte MaxTimeDenom = 60 / (8 / CoordRate);
constexpr byte BonusRate = 2;

word Score;
// word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte HeldKnifeCount;
static byte Clock;

void _deb(){}

void Main()
{
    // HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
    StageTime = 0;
    HeldKnifeCount = 0;
    
    title:
    Title();
    byte key;
    do {
        if (ScanStop()) return;
        key = ScanKeysWait();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);
    
    while (ScanKeys() != 0);
    Score = 0;
    if ((key & Keys_Button1) == 0 && (key & Keys_Dir) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;
    stage:
    InitStage();
    try:
    InitTrying();
    Clock = 0;
    byte timeDenom = MaxTimeDenom;
    Sound_Start();     
    StartBGM();
    do {
        if (ScanStop()) return;
        if ((Clock & 3) == 0) {
            MoveMan();
            MoveMonsters();
            UpdatePoints();

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
        MoveKnives();
        if ((Clock & 3) == 0) {
            DrawAll();
            WaitTimer(8 / CoordRate);
        }
        ++Clock;
        if ((Man.status & Movable_Live) == 0) {
            goto lose;
        }
    } while (!Reached);
    DrawAll();
    StopBGM();
    WaitTimer(10);
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(3);
        StageTime -= BonusRate;
        PrintTime();
        Sound_Beep();
    }
    StageTime = 0;
    PrintStatus();
    ++CurrentStage;
    goto stage;
}


void AddScore(word pts) 
{
    Score += pts;
    // if (Score > HiScore) {
    //     HiScore = Score;
    // }
    PrintScore();
}
