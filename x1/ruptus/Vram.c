#include "Vram.h"
#include "Chars.h"

extern byte[] Ascii, FortPattern;


static word WriteSpritePattern(word c, ptr<byte> pSource, byte size, byte add) 
{
    {
        ptr<byte> p;
        byte xCount, yCount;
        p = pSource;
        yCount = size;
        do {
            xCount = size;
            do {
                WritePattern(c, p);
                ++c;
                p += PatternSize;
                --xCount;
            } while (xCount != 0);
            --yCount;
        } while (yCount != 0);
    } 
    {
        ptr<byte> p;
        byte xCount, yCount;
        p = pSource;
        yCount = size;
        do {
            xCount = size;
            do {
                WritePatternH(c, p);
                ++c;
                p += PatternSize;
                --xCount;
            } while (xCount != 0);
            c += add;
            --yCount;
        } while (yCount != 0);
    } 
    {
        ptr<byte> p;
        byte xCount, yCount;
        p = pSource;
        yCount = size;
        do {
            xCount = size;
            do {
                WritePatternV(c, p, size);
                ++c;
                p += PatternSize;
                --xCount;
            } while (xCount != 0);
            --yCount;
        } while (yCount != 0);
        xCount = size;
        do {
            c += add;
            --xCount;
        } while (xCount != 0);
    } 
    {
        ptr<byte> p;
        byte xCount, yCount;
        p = pSource;
        yCount = size;
        do {
            xCount = size;
            do {
                WritePatternHV(c, p, size + add);
                ++c;
                p += PatternSize;
                --xCount;
            } while (xCount != 0);
            c += add;
            --yCount;
        } while (yCount != 0);
        xCount = size;
        do {
            c += add;
            --xCount;
        } while (xCount != 0);
        c += add;
    }
    return c;
}

void InitVram() 
{
    word c;

    ClearScreen();
    ClearSpriteRam();

    SetPcgMono(Char_Ascii, AsciiPattern, 0x40, 0x07); 
    SetPcgMono(Char_Logo, LogoPattern, 16, 0x05);
    SetPcgMono(Char_Barrier, BarrierPattern, 4, 0x06);
    SetPcgColor(Char_Remain, SpritePattern + PatternSize * 6, 4);
    SetPcgMono(Char_Map, MapPattern, 2, 0x15);
    WriteSpritePattern(1, FortPattern, 6, 0);
    SetPcgColor(Char_Fort, SpriteRam + PatternSize, 6 * 6 * 4);
    {
        static byte[8] pattern;
        word c;
        byte b;
        c = Char_Star;
        b = 0x40;
        do {
            byte n, i;
            ptr<byte> pPattern;
            n = ((c >> 1) & 0x6) + 1;
            pPattern = pattern;
            i = 0;
            while (i < n) {
                *pPattern = 0;
                ++pPattern;
                ++i;
            }
            *pPattern = b;
            ++pPattern;
            ++i;
            while (i < CharHeight) {
                *pPattern = 0;
                ++pPattern;
                ++i;
            }
            SetPcgMono(c, pattern, 1, 0x0f);
            b >>= 2;
            if (b == 0) {
                b = 0x40;
            }
            ++c;
        } while (c < Char_Star + 16);
    }
    ClearSpriteRam();
    {
        ptr<byte> pSource;
        word c;
        pSource = SpritePattern;
        c = GChar_FighterBullet;

        repeat (6) {
            c = WriteSpritePattern(c, pSource, 1, 1);
            pSource += PatternSize;
        }  
        repeat (18) {
            c = WriteSpritePattern(c, pSource, 2, 1);
            pSource += PatternSize * 2 * 2;
        } 
        c = WriteSpritePattern(c, pSource, 4, 1);
        pSource += PatternSize * 4 * 4;
    } 
}
