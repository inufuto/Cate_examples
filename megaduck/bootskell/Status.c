#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "Scroll.h"
#include "Stage.h"

static word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
    return address;
}

void PrintStatus() 
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    // PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 7 * VramStep, "ST");
    PrintByteNumber2(Vram + VramRowSize + 7 * VramStep, CurrentStage + 1);
    PrintS(Vram+ 10 * VramStep, "TIME");
    {
        word vram;
        vram = Vram + 15 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                vram = Put2C(vram, Char_Remain);
                --i;
            } while (i > 0);
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    word address;
    address = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(address, '0');
    // address = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    // PrintC(address, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 11 * VramStep, StageTime);
}

// static void EraseWindow() 
// {
//     constexpr byte width = 12;
//     constexpr byte height = 3;    
//     word address;

//     address = Vram + VramRowSize * 11 + 10 * VramStep;
//     repeat (height) {
//         repeat (width) {
//             address = PrintC(address, ' ');
//         }
//         address += VramRowSize - width;
//     }
// }

void PrintGameOver()
{
    // EraseWindow();
    PrintS(Vram + VramRowSize * 7 + (24 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    // EraseWindow();
    PrintS(Vram + VramRowSize * 7 + (24 - 7) / 2 * VramStep, "TIME UP");
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
            0x4f, 0x4d, 0x42, 0x40, 
            0x4f, 0x4e, 0x41, 0x4e, 
            0x4f, 0x4c, 0x43, 0x4f, 
            0x45, 0x45, 0x40, 0x44, 
            0x40, 0x40, 0x40, 0x40, 
            0x49, 0x48, 0x47, 0x46, 
            0x4c, 0x4c, 0x43, 0x43, 
            0x41, 0x40, 0x45, 0x40, 
            0x4a, 0x40, 0x40, 0x40, 
            0x4f, 0x41, 0x4e, 0x41, 
            0x4f, 0x40, 0x4d, 0x43, 
            0x44, 0x41, 0x45, 0x40, 
            0x4a, 0x40, 0x40, 0x40, 
            0x4f, 0x4e, 0x41, 0x4e, 
            0x4f, 0x4b, 0x40, 0x4f, 
            0x45, 0x44, 0x41, 0x44, 
            0x40, 0x48, 0x42, 0x4a, 
            0x49, 0x4c, 0x43, 0x4f, 
            0x45, 0x4c, 0x43, 0x4f, 
            0x45, 0x44, 0x41, 0x45, 
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
}


void DrawFence()
{
    word vram;
    vram = Vram + VramRowSize * 16;
    repeat(StageWidth) {
        vram = Put(vram, Char_Fence);
    }
}