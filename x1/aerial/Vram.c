#include "Vram.h"
#include "Chars.h"

extern byte[] MonoPattern, BulletPattern, ColorPattern, AsciiPattern;


void InitVram()
{
    ClearScreen();

    SetPcgMono(Char_Ascii, AsciiPattern, 7, 0x40);
    SetPcgMono(Char_Logo, MonoPattern + (Char_Logo - Char_Logo) * CharHeight, 6, 16);
    SetPcgMono(Char_Ground, MonoPattern + (Char_Ground - Char_Logo) * CharHeight, 6, 3);
    SetPcgMono(Char_MyBuulet, BulletPattern, 7, 4);
    SetPcgMono(Char_EnemyBullet, BulletPattern, 6, 4);
    SetPcgColor(Char_MyFighter, ColorPattern, Char_End - Char_MyFighter);
}
