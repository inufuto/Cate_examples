#include "Vram.h"
#include "Chars.h"

extern byte[] AsciiPattern;
extern byte[] LogoPattern;
extern byte[] BarrierPattern;
extern byte[] SpritePattern;
extern byte[] FortPattern;
extern byte[] TerrainPattern;

void InitVram()
{
    ClearScreen();

    SetPcgMono(Char_Ascii, AsciiPattern, 7, 0x40);
    SetPcgMono(Char_Logo, LogoPattern, 5, 16);
    SetPcgMono(Char_Barrier, BarrierPattern, 6, 2);
    SetPcgColor(Char_Remain, SpritePattern + PatternSize * 4, 4);
    SetPcgColor(Char_Fort, FortPattern, 6 * 6);
    SetPcgColor(Char_Terrain, TerrainPattern, 26 * 2);

    {
        byte c;
        ptr<byte> pLower, pUpper;
        c = Char_Fort + 6 * 6;
        pLower = FortPattern;
        pUpper = pLower;
        repeat(6) {
            SetPcgHalf(c, SpritePattern, pLower);
            ++c;
            pLower += PatternSize;
        }
        repeat(6 - 1) {
            repeat(6) {
                SetPcgHalf(c, pUpper, pLower);
                ++c;
                pUpper += PatternSize;
                pLower += PatternSize;
            }
        }
        repeat(6) {
            SetPcgHalf(c, pUpper, SpritePattern);
            ++c;
            pUpper += PatternSize;
        }
    }
}
