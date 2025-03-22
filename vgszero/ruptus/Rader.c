#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"
#include "VVram.h"
#include "Sprite.h"

constexpr byte RaderTop = VVramHeight - 12;
constexpr byte RaderLeft = 1 + VVramWidth;

void PrintRader()
{
    ptr<byte> pVram = VramBack + VramRowSize * RaderTop + RaderLeft * VramStep;
    repeat(12) {
        repeat(8) {
            pVram = Put(pVram, Char_Map);
        }
        pVram += VramRowSize - 8 * VramStep;
    }
}

void DrawFortRader(byte x, byte y, bool visible)
{
    x >>= 4;
    y >>= 4;
    Put(VramBack + VramOffset(RaderLeft + x, RaderTop + y), visible ? Char_Map + 1 : Char_Map);
}


void DrawFighterOnRader()
{
    ShowSprite(
        Sprite_MapPoint,
        8 * (RaderLeft - 1) - 1 + (FighterX >> 1),
        8 * RaderTop - 1 + (FighterY >> 1), 
        Pattern_FighterOnMap
    );
}
