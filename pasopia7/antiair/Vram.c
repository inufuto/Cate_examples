#include "Vram.h"
#include "Chars.h"

extern byte[] Backup;
extern byte[] MonoPattern, BulletPattern, ColorPattern, AsciiPattern;


void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, AsciiPattern, 0x40, 7);
    MakePatternMono(Char_Logo, MonoPattern + (Char_Logo - Char_Logo) * CharHeight, 16, 6);
    MakePatternMono(
        Char_Ground, MonoPattern + (Char_Ground - Char_Logo) * CharHeight, 3, 6
    );
    MakePatternMono(Char_MyBuulet, BulletPattern, 4, 7);
    MakePatternMono(Char_EnemyBullet, BulletPattern, 4, 6);
    MakePatternColor(Char_MyFighter, ColorPattern, Char_End - Char_MyFighter);
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + VramStep;
}
