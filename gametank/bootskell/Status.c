#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr word AsciiRowHeight = VramWidth * AsciiHeight;

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
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + AsciiRowHeight + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + 22 * VramStep, "TIME");

    {
        word vram;
        vram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                byte c;
                c = Char_Remain;
                repeat (2) {
                    repeat (2) {
                        vram = Put(vram, c);
                        ++c;
                    }
                    vram += VramRowSize - 2 * VramStep;
                }
                vram += 2 * VramStep - VramRowSize * 2;
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
    
    address = PrintNumber5(Vram + AsciiRowHeight, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + AsciiRowHeight + 9 * VramStep, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + AsciiRowHeight + 23 * VramStep, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
    DrawAll();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 12, "TIME UP");
    DrawAll();
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
        vram = Vram + VramRowSize * 7 + (32 - 4 * 6) / 2 * VramStep;
        p = TitleBytes;
        repeat (6) {
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
    PrintS(Vram + AsciiRowHeight * 13 + 11 * VramStep, "S:START");
    PrintS(Vram + AsciiRowHeight * 14 + 11 * VramStep, "C:CONTINUE");
    PrintS(Vram + AsciiRowHeight * 16 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram + VramRowSize * 3;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - CharWidth * 16;
    //         }
    //     }
    // }
    PresentBackground();
    SwitchPage();
}


void DrawFence()
{
    word vram = Vram + AsciiRowHeight * 2 + VramRowSize * VVramHeight;
    repeat(VVramWidth) {
        vram = Put(vram, Char_Fence);
    }
}