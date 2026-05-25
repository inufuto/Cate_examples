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
        word vram;
        vram =  + VramWidth * 21 + 66;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                byte c;
                c = Char_Man;
                repeat (2) {
                    repeat (2) {
                        vram = Put(vram, c);
                        ++c;
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

    vram = Vram + VramWidth * 10 + 10 * 2;
    repeat (height) {
        repeat (width) {
            vram = Put(vram, Char_Space);
        }
        vram += VramWidth - width * 2;
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
		0x0f, 0x05, 0x0d, 0x02, 
		0x0f, 0x0a, 0x0e, 0x01, 
		0x0f, 0x00, 0x0c, 0x03, 
		0x05, 0x05, 0x05, 0x00, 
		0x00, 0x00, 0x00, 0x00, 
		0x0e, 0x0d, 0x02, 0x0e, 
		0x0f, 0x0c, 0x03, 0x0f, 
		0x04, 0x05, 0x00, 0x04, 
		0x00, 0x00, 0x08, 0x02, 
		0x0d, 0x02, 0x0d, 0x07, 
		0x0c, 0x03, 0x0c, 0x03, 
		0x05, 0x00, 0x00, 0x05, 
		0x00, 0x00, 0x00, 0x0c, 
		0x08, 0x07, 0x05, 0x0c, 
		0x00, 0x05, 0x0b, 0x0c, 
		0x04, 0x05, 0x01, 0x04, 
		0x03, 0x00, 0x00, 0x00, 
		0x0b, 0x07, 0x08, 0x07, 
		0x0f, 0x02, 0x0c, 0x07, 
		0x01, 0x05, 0x00, 0x05, 
		0x00, 0x0c, 0x03, 0x0f, 
		0x0b, 0x0c, 0x03, 0x0f, 
		0x05, 0x0c, 0x03, 0x0f, 
		0x01, 0x04, 0x01, 0x05, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramWidth * 7 + 4 * 2;
        p = TitleBytes;
        repeat (6) {
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
    PrintS(Vram + VramWidth * 18 + 18, "PUSH SPACE KEY");
    PrintS(Vram + VramWidth * 20 + 18, "OR GRPH KEY");
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