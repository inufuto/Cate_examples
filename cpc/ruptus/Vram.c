#include "Vram.h"
#include "Chars.h"

extern byte[] 
    LogoPattern, AsciiPattern, BarrierPattern, MapPattern, FighterBulletPattern,
    EnemyBulletPattern, FortPattern, SpritePattern;


void InitVram() 
{
    MakePatternMono(Char_Logo, LogoPattern, 16, 0x02);
    MakePatternMono(Char_Ascii, AsciiPattern, 0x40, 0x03); 
    MakePatternMono(Char_Barrier, BarrierPattern, 2, 0x03);
    MakePatternMono(Char_Map, MapPattern, 2, 0x02);
    MakePatternMono(Char_FighterBullet, FighterBulletPattern, 4, 0x03); 
    MakePatternMono(Char_EnemyBullet, EnemyBulletPattern, 1, 0x01); 
    MakePatternColor(Char_Fort, FortPattern, 6 * 6);
    MakePatternColor(Char_BarrierHead, SpritePattern, 89);
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
            b >>= 2;
            if (b == 0) {
                b = 0x40;
            }
            MakePatternMono(c, pattern, 1, 0x03);
            ++c;
        } while (c < Char_Star + 16);
    }
}


word PrintC(word vram, byte c)
{
    VPut1(vram, c);
    return vram + 2;
}


void VPut2(word vram, byte c) 
{
    word v;
    v = vram;
    repeat(2) {
        repeat(2) {
            VPut1(v, c);
            ++c;
            v += 2;
        }
        v += VramRowSize - 4;
    }
}


void VErase2(word vram)
{
    word v;
    v = vram;
    repeat(2) {
        repeat(2) {
            VPut1(v, Char_Space);
            v += 2;
        }
        v += VramRowSize - 4;
    }
}