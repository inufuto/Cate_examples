#include "Status.h"
#include "Vram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

extern bool JoystickAvailable;

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}

void PrintStatus()
{
    PrintS(Vram + VramRowSize * 0 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 3 + WindowWidth * VramStep, "HIGH");
    PrintS(Vram + VramRowSize * 4 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 7 + WindowWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 7 + (WindowWidth + 6) * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 1 + (WindowWidth + 2) * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 5 + (WindowWidth + 2) * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    vram = Vram + VramRowSize * 21 + (WindowWidth + 1) * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain);
            vram = Erase2(vram);
            vram += VramRowSize - 2 * VramStep;
            vram = Put(vram, i + 0x10);
            vram += 1 * VramStep - VramRowSize;
        }
        else {
            do {
                vram = Put2C(vram, Char_Remain);
                --i;
            } while (i > 0);
        }
    }
    if (RemainCount < 3) {
        vram = Erase2(vram);
    }
}


void PrintGameOver()
{
    constexpr byte Left = (WindowWidth - 8) / 2;
    PrintS(Vram + VramRowSize * (VramHeight / 2) + Left * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	G
            0x40, 0x4e, 0x45, 0x4b, 
            0x4c, 0x43, 0x4a, 0x4a, 
            0x44, 0x4b, 0x40, 0x4f, 
            0x40, 0x44, 0x45, 0x45, 
            //	U
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
            //	N
            0x4c, 0x4b, 0x40, 0x4f, 
            0x4c, 0x4f, 0x4b, 0x4f, 
            0x4c, 0x43, 0x4d, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	T
            0x44, 0x4d, 0x47, 0x41, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x44, 0x41, 0x40, 
            //	U
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
            //	S
            0x48, 0x47, 0x45, 0x4b, 
            0x44, 0x4b, 0x4a, 0x42, 
            0x48, 0x42, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (WindowWidth - LogoLength * 4)  * VramStep / 2;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    if (JoystickAvailable) {
        PrintS(Vram + VramRowSize * 19 + (WindowWidth - 19) * VramStep / 2, "PUSH TRIGGER BUTTON");
    }
    else {
        PrintS(Vram + VramRowSize * 19 + (WindowWidth - 14) * VramStep / 2, "PUSH SPACE KEY");
        PrintS(Vram + VramRowSize * 20 + (WindowWidth - 14) * VramStep / 2, "OR SHIFT KEY");
    }
    PrintS(Vram + VramRowSize * 23 + (WindowWidth - 12) * VramStep, "INUFUTO 2024");
    
    // {
    //     byte c;
    //     word v;
    //     EnemyRowLeft = 0;
    //     while (ScanKeys() == 0) {
    //         UpdateEnemyChars();
    //         v = Vram;
    //         c = 0;
    //         repeat (0) {
    //             v = Put(v, c);
    //             ++c;
    //             if ((c & 15) == 0) {
    //                 v += VramRowSize - 16 * VramStep;
    //             }
    //         }
    //         ++EnemyRowLeft;
    //         WaitTimer(30);
    //     }
    // }
}


void AddScore(word pts)
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}
