#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

extern void _deb();

constexpr byte Char_Remain = Char_Sprite;

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
    PrintS(Vram[1].chars + 64, "SCORE");
    PrintS(Vram[6].chars + 64, "HI-SCORE");
    PrintS(Vram[11].chars + 64, "STAGE");
    PrintByteNumber2(Vram[11].chars + 76, CurrentStage + 1);
    // {
    //     ptr<VramRow> pVram;
    //     pVram = &Vram[23];
    //     repeat (2) {
    //         pVram->attrs[0].column = 0;
    //         pVram->attrs[0].attr = 0x38;
    //         pVram->attrs[1].column = 64;
    //         pVram->attrs[1].attr = 0x58;
    //         ++pVram;
    //     }
    // }
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram[3].chars + 68, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram[8].chars + 68, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = Vram[22].chars + 66;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Sprite);
            Erase2(pVram);
            PrintC(pVram, i + '0');
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Sprite);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(pVram);
    }
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3 + 1;    

    ptr<byte> pVVram = VVramFront + VVramWidth * 9 + 10;
    repeat (height) {
        repeat (width) {
            *pVVram = Char_White;
            ++pVVram;
        }
        pVVram += VVramWidth - width;
    }
    VVramToVram();
}


void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram[11].chars + 24, "GAME OVER");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x02, 0x10, 0x07, 0x0d, 
            0x02, 0x0f, 0x0c, 0x04, 
            0x02, 0x0c, 0x02, 0x11, 
            0x02, 0x06, 0x07, 0x03, 
            0x0e, 0x05, 0x04, 0x11, 
            0x0e, 0x05, 0x05, 0x11, 
            0x06, 0x07, 0x07, 0x03, 
            0x02, 0x02, 0x02, 0x02, 
            0x0a, 0x09, 0x0d, 0x0e, 
            0x0e, 0x05, 0x11, 0x0e, 
            0x02, 0x07, 0x03, 0x06, 
            0x02, 0x02, 0x02, 0x02, 
            0x09, 0x0d, 0x0e, 0x09, 
            0x0d, 0x09, 0x0e, 0x05, 
            0x03, 0x07, 0x06, 0x07, 
            0x02, 0x02, 0x02, 0x02, 
            0x0d, 0x02, 0x11, 0x0a, 
            0x11, 0x02, 0x11, 0x0e, 
            0x03, 0x02, 0x11, 0x0e, 
            0x02, 0x02, 0x07, 0x07, 
            0x0e, 0x05, 0x02, 0x02, 
            0x0e, 0x05, 0x10, 0x0f, 
            0x0e, 0x05, 0x11, 0x0e, 
            0x07, 0x02, 0x06, 0x07, 
            0x02, 0x02, 0x02, 0x02, 
            0x04, 0x11, 0x0f, 0x04, 
            0x05, 0x11, 0x10, 0x03, 
            0x02, 0x07, 0x06, 0x03, 
            0x02, 0x02, 0x02, 0x02, 
            0x11, 0x0a, 0x09, 0x02, 
            0x11, 0x0f, 0x04, 0x02, 
            0x07, 0x02, 0x07, 0x02, 
        };
        ptr<byte> p;
        ptr<byte> pVVram;
        pVVram = VVramFront + VVramWidth * 6 + 0;
        p = TitleBytes;
        repeat (8) {
            repeat (4) {
                repeat (4) {
                    byte c = *p; ++p;
                    if (c != 0) {
                        *pVVram = c; 
                    }
                    ++pVVram;
                }
                pVVram += VVramWidth - 4;
            }
            pVVram += 4 - VVramWidth * 4;
        }
    }
    VVramToVram();
    PrintS(Vram[17].chars + 18, "PUSH SPACE KEY");
    PrintS(Vram[19].chars + 18, "OR GRPH KEY");
    PrintS(Vram[22].chars + 40, "INUFUTO 2026");
}


static void DrawFenceH(ptr<VramRow> pRow, byte b)
{
    ptr<byte> pChar;
    ptr<VramAttr> pAttr;
    pChar = pRow->chars;
    repeat (VVramWidth * 2) {
        *pChar = b;
        ++pChar;
    }
    pAttr = pRow->attrs;
    pAttr->column = 0;
    pAttr->attr = 0x38;
    repeat(19) {
        ++pAttr;
        pAttr->column = 64;
        pAttr->attr = 0xf8;
    }
}

void DrawFence()
{
    DrawFenceH(Vram + 1, 0x88);
    DrawFenceH(Vram + 24, 0x11);
}