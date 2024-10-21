#include "Status.h"
#include "Vram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"
#include "ScanKeys.h"

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
    PrintS(Vram + 1 * VramStep, "SCORE");
    // PrintS(Vram + VramRowSize * 3 + WindowWidth * VramStep, "HIGH");
    PrintS(Vram + 7 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 9 * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
}

void PrintScore()
{
    word address;
    address = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(address, '0');
    // vram = PrintNumber5(Vram + VramRowSize * 5 + WindowWidth * VramStep, HiScore);
    // PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    vram = Vram + 15 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain);
            vram = Erase2(vram);
            vram += (VramWidth - 2) * VramStep;
            vram = PrintC(vram, i + 0x30);
            vram += (1 - VramWidth) * VramStep;
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
    PrintS(Vram + VramRowSize * 7 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x4e, 0x45, 0x4b, 0x4c, 
            0x4f, 0x48, 0x4a, 0x4c, 
            0x4f, 0x40, 0x4f, 0x4c, 
            0x44, 0x45, 0x41, 0x40, 
            0x43, 0x4f, 0x4c, 0x47, 
            0x43, 0x4f, 0x4c, 0x43, 
            0x43, 0x4f, 0x4c, 0x43, 
            0x45, 0x41, 0x44, 0x41, 
            0x4b, 0x44, 0x4f, 0x41, 
            0x4f, 0x40, 0x4f, 0x40, 
            0x4f, 0x40, 0x4f, 0x40, 
            0x45, 0x40, 0x45, 0x40, 
            0x4f, 0x4c, 0x43, 0x4e, 
            0x4f, 0x4c, 0x43, 0x4d, 
            0x4f, 0x4c, 0x43, 0x4a, 
            0x44, 0x45, 0x40, 0x44, 
            0x4d, 0x42, 0x40, 0x40, 
            0x4a, 0x40, 0x40, 0x40, 
            0x4c, 0x43, 0x40, 0x40, 
            0x45, 0x40, 0x40, 0x40, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 4 + (20 - 4 * LogoLength) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 8 + ((20 + 4 * LogoLength) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 15 + 1 * VramStep, "PUSH START BUTTON");
    PrintS(Vram + VramRowSize * 17 + 8 * VramStep, "INUFUTO 2024");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}


void AddScore(word pts)
{
    Score += pts;
    // if (Score > HiScore) {
    //     HiScore = Score;
    // }
    PrintScore();
}
