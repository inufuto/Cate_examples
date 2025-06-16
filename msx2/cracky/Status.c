#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

extern void _deb();

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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramWidth + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");
    {
        byte x, y, sprite;
        x = 27 * CoordRate;
        y = -1;
        sprite = Sprite_Remain;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                ShowSpriteF(sprite, x, y, Pattern_Man);
                Put(Vram + 29, i + 0x10);
                sprite += 2;
            }
            else {
                do {
                    ShowSpriteF(sprite, x, y, Pattern_Man);
                    x += 2 * CoordRate;
                    sprite += 2;
                    --i;
                } while (i > 0);
            }
        }
        while (sprite < Sprite_Color) {
            ShowSpriteF(sprite, x, -CoordRate * 2 - 1, Pattern_Man);
            ++sprite;
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    word address;
    
    address = PrintNumber5(Vram + VramWidth, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + VramWidth + 9, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramWidth + 23, StageTime);
}

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
        //	C
        0x40, 0x4e, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x4b, 0x40, 0x4a, 
        0x40, 0x44, 0x45, 0x41, 
        //	R
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x48, 0x4f, 
        0x4c, 0x47, 0x4f, 0x42, 
        0x44, 0x41, 0x44, 0x45, 
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	C
        0x40, 0x4e, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x4b, 0x40, 0x4a, 
        0x40, 0x44, 0x45, 0x41, 
        //	K
        0x4c, 0x43, 0x48, 0x47, 
        0x4c, 0x4b, 0x47, 0x40, 
        0x4c, 0x43, 0x4d, 0x42, 
        0x44, 0x41, 0x40, 0x45, 
        //	Y
        0x4c, 0x43, 0x4c, 0x43, 
        0x44, 0x4b, 0x4e, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
   };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    // UpdateSprites();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramWidth * 7 + (32 - 6 * 4) / 2;
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
    PrintS(Vram + VramWidth * 23 + 20, "INUFUTO 2024");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16;
    //         }
    //     }
    // }
}