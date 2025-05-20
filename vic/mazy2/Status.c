#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Pattern_Remain = Pattern_Man;

extern byte[] Chars;

static void PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    Locate(pVram);
    while ((c = *p) != 0) {
        PrintC(c);
        ++p;
    }
    EndPrint();
}


void PrintStatus() 
{
    CurrentChar(Char_Score);
    PrintS(Vram + 2, "SCORE");
    PrintS(Vram + 6, "HI-SCORE");
    PrintS(Vram + 11, "STAGE");
    PrintS(Vram + 15, "TIME");
    EndPrint();

    CurrentChar(Char_StageValue);
    PrintByteNumber2(Vram + VramRowSize + 12, CurrentStage + 1);
    EndPrint();
    {
        ptr<byte> pVram = Vram + 20;
        if (RemainCount > 1) {
            byte c = Char_Remain;
            byte pattern = Pattern_Remain;
            repeat (2) {
                LocatePattern(pVram, 0, c);
                repeat (2) {
                    PutPattern(pattern);
                    ++pattern;
                }
                PutColor(pVram, 1, 3);
                pVram += VramRowSize;
                c += 2;
            }
            byte i = RemainCount - 1;
            if (i > 1) {
                pVram += 2 - VramRowSize;
                Locate(pVram);
                PrintC(i + '0');
            }
        }
    }
    {
        LocatePattern(Vram + 18, 0, Char_HeldKnife);
        PutPattern(Pattern_Knife);
        // PutColor(pVram, 1, 3);
    }
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    CurrentChar(Char_ScoreValue);
    PrintNumber5(Vram + VramRowSize + 2, Score);
    PrintC('0');
    EndPrint();

    CurrentChar(Char_HiScoreValue);
    PrintNumber5(Vram + VramRowSize + 7, HiScore);
    PrintC('0');
    EndPrint();
}

void PrintTime()
{
    CurrentChar(Char_TimeValue);
    PrintByteNumber3(Vram + VramRowSize + 15, StageTime);
    EndPrint();
}

void PrintHeldKnives()
{
    CurrentChar(Char_KnifeValue);
    PrintByteNumber2(Vram + VramRowSize + 18, HeldKnifeCount);
    EndPrint();
}


void PrintGameOver()
{
    CurrentChar(Char_Message);
    PrintS(Vram + VramRowSize * 12 + 10, "GAME OVER");
}

void PrintTimeUp() 
{
    CurrentChar(Char_Message);
    PrintS(Vram + VramRowSize * 12 + 10, " TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	M
            0x0c, 0x07, 0x07, 0x0b, 
            0x0c, 0x03, 0x03, 0x0f, 
            0x0c, 0x03, 0x03, 0x0f, 
            0x04, 0x01, 0x01, 0x05, 
            //	A
            0x00, 0x0e, 0x0d, 0x02, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x07, 0x05, 0x0f, 
            0x04, 0x01, 0x00, 0x05, 
            //	Z
            0x04, 0x05, 0x0d, 0x07, 
            0x00, 0x08, 0x07, 0x00, 
            0x08, 0x07, 0x00, 0x00, 
            0x04, 0x05, 0x05, 0x05, 
            //	Y
            0x0c, 0x03, 0x0c, 0x03, 
            0x04, 0x0b, 0x0e, 0x01, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x04, 0x01, 0x00, 
            //	2
            0x08, 0x07, 0x05, 0x0b, 
            0x00, 0x08, 0x0e, 0x07, 
            0x08, 0x0f, 0x05, 0x00, 
            0x04, 0x05, 0x05, 0x05, 
        };
        constexpr byte LogoLength = 5;
        constexpr byte left = (32 - 4 * LogoLength) / 2;
        ptr<byte> p;
        ptr<byte> pVram;
        byte c;

        pVram = Vram + VramRowSize * 7 + left * 3 / 4;
        c = Char_Logo;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                LocatePattern(pVram, 0, c);
                repeat (4) {
                    ptr<byte> pPattern;
                    PutPattern(*p);
                    ++p;
                }
                PutColor(pVram, 3, 3);
                pVram += VramRowSize;
                c += 3;
            }
            pVram += 3 - VramRowSize * 4;
        }
        // FillMemory(ColorMap + VramRowSize * 7, 4 * VramRowSize, 6);
    }
    CurrentChar(Char_Message2);
    PrintS(Vram + VramRowSize * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9, "OR 'Z' KEY");
    PrintS(Vram + VramRowSize * 23 + 18, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
    //     byte c = Char_Background;
    //     repeat (Char_End - Char_Background) {
    //         PutColor(pVram, 9, 1);
    //         *pVram = c; ++pVram;
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}