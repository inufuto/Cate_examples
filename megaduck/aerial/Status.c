#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"


static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}


static word PrintRemain(word vram)
{
    byte c;
    c = Char_Remain;
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            c += 2;
        }
        vram += VramRowSize - 2 * VramStep;
        c += 1 - 4;
    }
    return vram + (2 * VramStep - VramRowSize * 2);
}


static word EraseRemain(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2;
    }
    return vram + (2 - VramRowSize * 2);
}


void PrintStatus() 
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    // PrintS(Vram + 8 * VramStep, "HI-SCORE");
    PrintS(Vram + 7 * VramStep, "STAGE");
    {
        word vram;
        vram = Vram + 15 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = PrintRemain(vram);
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 2 * VramStep;
                vram = Put(vram, i + 0x10);
                vram = Put(vram, Char_Space);
            }
            else {
                do {
                    vram = PrintRemain(vram);
                    --i;
                } while (i != 0);
                EraseRemain(vram);
            }
        }
        else {
            EraseRemain(vram);           
        }
    }
    PrintStage();
    PrintScore();
    // PrintTime();
}

void PrintScore()
{
    word vram;
    vram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(vram, '0');
    // vram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    // PrintC(vram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize + 9 * VramStep, CurrentStage + 1);
}

// void PrintTime()
// {
//     PrintByteNumber3(Vram + VramRowSize + 23, StageTime);
// }

// static void EraseWindow() 
// {
//     constexpr byte width = 12;
//     constexpr byte height = 3;    
//     word vram;

//     vram = Vram + VramRowSize * 11 + 10 * VramStep;
//     repeat (height) {
//         repeat (width) {
//             vram = PrintC(vram, ' ');
//         }
//         vram += VramRowSize - width;
//     }
// }

void PrintGameOver()
{
    // EraseWindow();
    PrintS(Vram + VramRowSize * 7 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

// void PrintTimeUp() 
// {
//     EraseWindow();
//     PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
// }

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x48, 0x4f, 0x42, 0x4c, 
            0x4f, 0x40, 0x4f, 0x4c, 
            0x4f, 0x45, 0x4f, 0x4c, 
            0x45, 0x40, 0x45, 0x44, 
            0x47, 0x45, 0x41, 0x4f, 
            0x4b, 0x4a, 0x42, 0x4f, 
            0x43, 0x40, 0x40, 0x4f, 
            0x45, 0x45, 0x41, 0x45, 
            0x45, 0x4b, 0x44, 0x4f, 
            0x48, 0x47, 0x40, 0x4f, 
            0x4d, 0x42, 0x40, 0x4f, 
            0x40, 0x45, 0x44, 0x45, 
            0x41, 0x48, 0x4f, 0x42, 
            0x40, 0x4f, 0x40, 0x4f, 
            0x40, 0x4f, 0x45, 0x4f, 
            0x41, 0x45, 0x40, 0x45, 
            0x4c, 0x43, 0x40, 0x40, 
            0x4c, 0x43, 0x40, 0x40, 
            0x4c, 0x43, 0x40, 0x40, 
            0x44, 0x45, 0x45, 0x41, 
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
    //     SetFortChars();
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
