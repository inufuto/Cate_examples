#include "Status.h"
#include "Vram.h"
#include "Stage.h"
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

void PrintStatus() 
{
    PrintS(Vram + VramWidth * 1 + 64, "SCORE");
    PrintS(Vram + VramWidth * 6 + 64, "HI-SCORE");
    PrintS(Vram + VramWidth * 11 + 64, "STAGE");
    PrintByteNumber2(Vram + VramWidth * 11 + 76, CurrentStage + 1);
    PrintS(Vram + VramWidth * 14 + 64, "TIME");

    {
        static const byte[] RemainChars = {
            Char_MyFort + 2, 
            Char_MyFort + 3,
            Char_MyFort + 6,
            Char_MyFort + 7,
        };
        word vram;
        vram = Vram + VramWidth * 21 + 66;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                ptr<byte> pChars;
                pChars = RemainChars;
                repeat (2) {
                    repeat (2) {
                        vram = Put(vram, *pChars);
                        ++pChars;
                    }
                    vram += VramWidth - 2 * 2;
                }
                vram += 3 * 2 - VramWidth * 2;
                --i;
            } while (i > 0);
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramWidth * 3 + 68, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramWidth * 8 + 68, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramWidth * 14 + 74, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3 + 1;    
    word vram;

    vram = Vram + VramWidth * 10 + 20;
    repeat (height) {
        repeat (width) {
            vram = Put(vram, Char_Space);
        }
        vram += VramWidth - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramWidth * 11 + 24, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramWidth * 11 + VramWidth *  + 26, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	B
        0x0c, 0x07, 0x05, 0x0b, 
        0x0c, 0x0b, 0x0a, 0x07, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x04, 0x05, 0x05, 0x01, 
        //	A
        0x00, 0x0e, 0x0d, 0x02, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x0c, 0x07, 0x05, 0x0f, 
        0x04, 0x01, 0x00, 0x05, 
        //	T
        0x04, 0x0d, 0x07, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x04, 0x01, 0x00, 
        //	T
        0x04, 0x0d, 0x07, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x04, 0x01, 0x00, 
        //	L
        0x0c, 0x03, 0x00, 0x00, 
        0x0c, 0x03, 0x00, 0x00, 
        0x0c, 0x03, 0x00, 0x00, 
        0x04, 0x05, 0x05, 0x01, 
        //	O
        0x08, 0x07, 0x05, 0x0b, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x00, 0x05, 0x05, 0x01, 
        //	T
        0x04, 0x0d, 0x07, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x04, 0x01, 0x00, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramWidth * 7 + 2 * 2;
        p = TitleBytes;
        repeat (7) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramWidth - 4 * 2;
            }
            vram += 4 * 2 - VramWidth * 4;
        }
    }
    PrintS(Vram + VramWidth * 18 + 18, "PUSH SLOW KEY");
    PrintS(Vram + VramWidth * 20 + 18, "OR HTAB KEY");
}


void DrawFence()
{
    word top, bottom;
    top = Vram;
    bottom = Vram + VramWidth * 23;
    repeat(StageWidth) {
        top = Put(top, Char_Fence);
        bottom = Put(bottom, Char_Fence + 1);
    }
}