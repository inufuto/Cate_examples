#include "Status.h"
#include "Vram.h"
#include "Sprite.h"
#include "Print.h"
#include "Cannon.h"

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
    PrintS(Vram + 1, "SCORE");   
    PrintS(Vram + 7, "STAGE");
    {
        ptr<byte> pVram;
        pVram = Vram + 18;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2S(pVram, CannonChars);
                pVram = Erase2(pVram);
                PrintC(pVram - 2 + VramRowSize, i + 0x30);
            }
            else {
                do {
                    pVram = Put2S(pVram, CannonChars);
                    --i;
                } while (i > 0);
                pVram = Erase2(pVram);
            }
        }
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(Vram + VramRowSize * 1 + 0, Score);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize * 1 + 10, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + 8, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            0x80, 0x90, 0x80, 0x83, 
            0x80, 0x20, 0x80, 0x83, 
            0x80, 0x90, 0x80, 0xab, 
            0x90, 0x20, 0x90, 0x20, 
            0x80, 0x83, 0x82, 0x90, 
            0x80, 0x80, 0x82, 0x20, 
            0xac, 0xab, 0xac, 0x20, 
            0x20, 0x20, 0x20, 0x20, 
            0x80, 0x90, 0x83, 0x82, 
            0x80, 0x20, 0x83, 0x82, 
            0x90, 0x20, 0xab, 0xac, 
            0x20, 0x20, 0x20, 0x20, 
            0xa9, 0x80, 0x80, 0xaa, 
            0x83, 0x82, 0x83, 0x82, 
            0x83, 0x80, 0x80, 0x82, 
            0xab, 0xac, 0xab, 0xac, 
            0x20, 0x20, 0x20, 0x20, 
            0x80, 0x83, 0x80, 0x80, 
            0x80, 0x83, 0x80, 0x80, 
            0x90, 0xab, 0xac, 0x90, 
        };
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 3 + 2;
        p = TitleBytes;
        repeat (5) {
            repeat (4) {
                repeat (4) {
                    *pVram = *p; ++pVram;
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 7 + 16, "MINI");
    }

    PrintS(Vram + VramRowSize * 12 + 5, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 13 + 5, "OR 'Z' KEY");
    PrintS(Vram + VramRowSize * 15 + 12, "INUFUTO 2024");

    // PresendVram();
}


void AddScore(word pts)
{
    Score += pts;
    PrintScore();
}
