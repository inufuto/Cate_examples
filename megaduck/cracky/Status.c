#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
        ++p;
    }
    return pVram;
}

void PrintStatus() 
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    // PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 7 * VramStep, "ST");
    PrintByteNumber2(Vram + VramRowSize + 7 * VramStep, CurrentStage + 1);
    PrintS(Vram+ 10 * VramStep, "TIME");

    {
        ptr<byte> pVram = Vram + 15 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
            }
            else {
                do {
                    Put2C(pVram, Char_Remain);
                    pVram += 2 * VramStep;
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintTime();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');
    // pVram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    // PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 11 * VramStep, StageTime);
}

// static void EraseWindow() 
// {
//     constexpr byte width = 12;
//     constexpr byte height = 3;    
//     ptr<byte> pVram;

//     pVram = Vram + VramRowSize * 11 + 10 * VramStep;
//     repeat (height) {
//         repeat (width) {
//             pVram = PrintC(pVram, ' ');
//         }
//         ppVram += VramRowSize - width;
//     }
// }

void PrintGameOver()
{
    // EraseWindow();
    PrintS(Vram + VramRowSize * 7 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    // EraseWindow();
    PrintS(Vram + VramRowSize * 7 + (20 - 7) / 2 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    HScroll = 0;
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x4e, 0x45, 0x4b, 0x4c, 
            0x4f, 0x40, 0x40, 0x4c, 
            0x4f, 0x40, 0x4a, 0x4c, 
            0x44, 0x45, 0x41, 0x44, 
            0x47, 0x4d, 0x42, 0x4e, 
            0x4b, 0x4e, 0x41, 0x4f, 
            0x43, 0x4c, 0x43, 0x4f, 
            0x41, 0x44, 0x41, 0x45, 
            0x4d, 0x42, 0x4e, 0x45, 
            0x4c, 0x43, 0x4f, 0x40, 
            0x4d, 0x43, 0x4f, 0x40, 
            0x44, 0x41, 0x44, 0x45, 
            0x4b, 0x4c, 0x43, 0x4e, 
            0x40, 0x4c, 0x4f, 0x41, 
            0x4a, 0x4c, 0x47, 0x4b, 
            0x41, 0x44, 0x41, 0x44, 
            0x41, 0x4f, 0x40, 0x4f, 
            0x40, 0x4d, 0x4a, 0x47, 
            0x40, 0x40, 0x4f, 0x40, 
            0x41, 0x40, 0x45, 0x40, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> pVram = Vram + VramRowSize * 6 + (20 - 4 * LogoLength) / 2 * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 10 + ((20 + 4 * LogoLength) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 14 + 1 * VramStep, "PUSH START BUTTON");
    PrintS(Vram + VramRowSize * 16 + 8 * VramStep, "INUFUTO 2024");
    // {
    //     Movable m;
    //     m.x = 8*6;
    //     m.y = 8*3;
    //     m.sprite = 0;
    //     ShowSprite(&m, Char_Man);
    //     UpdateSprites();
    // }
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}