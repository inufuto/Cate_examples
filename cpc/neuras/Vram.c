#include "Vram.h"
#include "Stage.h"
#include "Chars.h"

extern byte[] Chars, Ascii;

byte[StageWidth * StageHeight] Backup;
byte[StageWidth * StageHeight] VVram;
byte[StageWidth * StageHeight] Backgnd;
byte[3] RowFlags;


void InitVram() 
{
    MakePatternMono(Char_Ascii, Ascii, 64, 3);
    MakePatternMono(Char_Wall, Chars + (Char_Wall - Char_Wall) * 8, 16, 2);
    MakePatternMono(Char_Solver, Chars + (Char_Solver - Char_Wall) * 8, 32, 3);
    MakePatternMono(Char_Monster, Chars + (Char_Monster - Char_Wall) * 8, 32, 1);
    MakePatternMono(Char_Card, Chars + (Char_Card - Char_Wall) * 8, 56, 3);
    MakePatternMono(Char_Title, Chars + (Char_Title - Char_Wall) * 8, 24, 2);
}


void SetRowFlag2(byte y)
{
    ptr<byte> pFlags;
    word bits;
    pFlags = RowFlags + (y >> 3);
    bits = (word)3 << (y & 7);
    pFlags[0] |= (byte)bits;
    pFlags[1] |= (byte)(bits >> 8);
}


static bool zeroVisible;
static byte byteValue;
word wordValue;

static word PrintDigitB(word vramAddress, byte n)
{
    byte c;
    
    c = 0;
    while (byteValue >= n) {
        ++c;
        byteValue -= n;
    }
    if (c == 0) {
        c = zeroVisible ? '0' : ' ';
    }
    else {
        zeroVisible = true;
        c += '0';
    }
    return PrintC(vramAddress, c);
}

word PrintByteNumber3(word vramAddress, byte b)
{
    zeroVisible = false;
    byteValue = b;
    vramAddress = PrintDigitB(vramAddress, 100);
    vramAddress = PrintDigitB(vramAddress, 10);
    vramAddress = PrintC(vramAddress, byteValue + '0');
    return vramAddress;
}

word PrintByteNumber2(word vramAddress, byte b)
{
    zeroVisible = false;
    byteValue = b;
    vramAddress = PrintDigitB(vramAddress, 10);
    vramAddress = PrintC(vramAddress, byteValue + '0');
    return vramAddress;
}


word PrintDigitW(word vramAddress, word n)
{
    byte c;
    
    c = 0;
    while (wordValue >= n) {
        ++c;
        wordValue -= n;
    }
    if (c == 0) {
        c = zeroVisible ? '0' : ' ';
    }
    else {
        zeroVisible = true;
        c += '0';
    }
    return PrintC(vramAddress, c);
}

word PrintNumber5(word vramAddress, word w) {
    zeroVisible = false;
    wordValue = w;
    vramAddress = PrintDigitW(vramAddress, 10000);
    vramAddress = PrintDigitW(vramAddress, 1000);
    vramAddress = PrintDigitW(vramAddress, 100);
    vramAddress = PrintDigitW(vramAddress, 10);
    vramAddress = PrintC(vramAddress, wordValue + '0');
    return vramAddress;
}

word PrintNumber3(word vramAddress, word w) {
    zeroVisible = false;
    wordValue = w;
    vramAddress = PrintDigitW(vramAddress, 100);
    vramAddress = PrintDigitW(vramAddress, 10);
    vramAddress = PrintC(vramAddress, wordValue + '0');
    return vramAddress;
}

void Print2x2(word vram, byte c) 
{
    c = (c << 2) + Char_Sprite;
    VPut(vram, c);
    ++c;
    VPut(vram + 2, c);
    ++c;
    VPut(vram + VramRowSize, c);
    ++c;
    VPut(vram + VramRowSize + 2, c);
}

void Erase2x2(word vram) 
{
    VPut(vram, Char_Space);
    VPut(vram + 2, Char_Space);
    VPut(vram + VramRowSize, Char_Space);
    VPut(vram + (VramRowSize + 2), Char_Space);
}

word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 2;
}
