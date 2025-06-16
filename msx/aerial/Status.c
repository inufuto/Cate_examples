#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

static word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
    return address;
}


static word PrintRemain(word vram)
{
    byte c;
    c = Char_Remain;
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VVramWidth - 2;
    }
    return vram + (2 - VVramWidth * 2);
}


static word EraseRemain(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VVramWidth - 2;
    }
    return vram + (2 - VVramWidth * 2);
}


void PrintStatus() 
{
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 8, "HI-SCORE");
    PrintS(Vram + 18, "STAGE");
    {
        word vram;
        vram = Vram + 27;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = PrintRemain(vram);
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VVramWidth - 2;
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
    word address;
    
    address = PrintNumber5(Vram + VramWidth, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + VramWidth + 9, HiScore);
    PrintC(address, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramWidth + 20, CurrentStage + 1);
}

// void PrintTime()
// {
//     PrintByteNumber3(Vram + VramWidth + 23, StageTime);
// }

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word address;

    address = Vram + VramWidth * 11 + 10;
    repeat (height) {
        repeat (width) {
            address = PrintC(address, ' ');
        }
        address += VramWidth - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 12, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	E
        0x4c, 0x47, 0x45, 0x41, 
        0x4c, 0x4b, 0x4a, 0x42, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	R
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x48, 0x4f, 
        0x4c, 0x47, 0x4f, 0x42, 
        0x44, 0x41, 0x44, 0x45, 
        //	I
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	L
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
    };

    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramWidth * 7 + (32 - 4 * 6) / 2;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramWidth - 4;
            }
            vram += 4 - VramWidth * 4;
        }
    }
    PrintS(Vram + VramWidth * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramWidth * 20 + 9, "OR GRPH KEY");
    PrintS(Vram + VramWidth * 23 + 20, "INUFUTO 2021");
    // {
    //     byte c;
    //     word v;
    //     v = Vram+32*10;
    //     c = 0;
    //     repeat (0) {
    //         v = Put(v, c);
    //         ++c;
    //     }
    // }
}
