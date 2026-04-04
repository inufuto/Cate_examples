#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Movable.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man;

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
    PrintByteNumber2(Vram + 7, CurrentStage + 1);
    {
        ptr<byte> pVram;
        pVram = Vram + 14;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                pVram = PrintC(pVram, Char_Space);
                pVram = PrintC(pVram, i + 0x30);
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain);
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
    ptr<byte> pVram = PrintNumber5(Vram, Score);
    PrintC(pVram, '0');
    // pVram = PrintNumber5(Vram + 11 * VramStep, HiScore);
    // PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + 10, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize6 * 6 + 5, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize6 * 6 + 6, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	L
            0x0c, 0x03, 0x00, 0x00, 
            0x0c, 0x03, 0x00, 0x00, 
            0x0c, 0x03, 0x00, 0x00, 
            0x04, 0x05, 0x05, 0x01, 
            //	I
            0x04, 0x0d, 0x07, 0x01, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x0c, 0x03, 0x00, 
            0x04, 0x05, 0x05, 0x01, 
            //	F
            0x0c, 0x07, 0x05, 0x01, 
            0x0c, 0x0b, 0x0a, 0x02, 
            0x0c, 0x03, 0x00, 0x00, 
            0x04, 0x01, 0x00, 0x00, 
            //	T
            0x04, 0x0d, 0x07, 0x01, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x04, 0x01, 0x00, 
        };
        constexpr byte LogoLength = 4;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize5 * 3 + (VramWidth - LogoLength * 2) / 2;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (2) {
                repeat (2) {
                    pVram = Put3L(pVram, *p); ++p;
                    pVram = Put3R(pVram, *p); ++p;
                }
                pVram += VramRowSize3 - 2;
                repeat (2) {
                    pVram = Put2L(pVram, *p); ++p;
                    pVram = Put2R(pVram, *p); ++p;
                }
                pVram += VramRowSize2 - 2;
            }
            pVram += 2 - VramWidth * 10;
        }
    }
    PrintS(Vram + VramRowSize6 * 7 + 3, "Z:START");
    PrintS(Vram + VramRowSize6 * 8 + 3, "X:CONTINUE");
    PrintS(Vram + VramWidth * 58 + VramWidth - 12, "INUFUTO 2026");
    // {
    //     byte c = 0;
    //     ptr<byte> pVram = Vram + VramRowSize6;
    //     repeat ((Char_End + 31) / 32) {
    //         repeat (8) {
    //             pVram = Put3L(pVram, c); ++c;
    //             pVram = Put3R(pVram, c); ++c;
    //         }
    //         pVram += VramRowSize3 - 8;
    //         repeat (8) {
    //             pVram = Put2L(pVram, c); ++c;
    //             pVram = Put2R(pVram, c); ++c;
    //         }
    //         pVram += VramRowSize2 - 8;
    //     }
    // }
}
