#include "Vram.h"
#include "Chars.h"

extern byte[] Backup;
extern byte[] MonoPattern, ColorPattern, AsciiPattern, TerrainPattern;

constexpr byte Char_Water = Char_Terrain + 5;
constexpr byte Char_Forest = Char_Terrain + 4;

void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, AsciiPattern, 0x40, 3);
    MakePatternMono(Char_Logo, MonoPattern + (Char_Logo - Char_Logo) * CharHeight, 16, 2);
    MakePatternMono(
        Char_FighterBullet, MonoPattern + (Char_FighterBullet - Char_Logo) * CharHeight, 3, 1
    );
    MakePatternMono(Char_Terrain, TerrainPattern, 10, 3);
    MakePatternMono(
        Char_Forest, 
        TerrainPattern + (Char_Forest - Char_Terrain) * CharHeight, 
        1, 2
    );
    MakePatternColor(Char_BarrierHead, ColorPattern, Char_Terrain - Char_BarrierHead);
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 2;
}
