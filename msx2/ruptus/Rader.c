#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"
#include "VVram.h"
#include "Sprite.h"

constexpr byte RaderTop = 12;
constexpr byte RaderLeft = VVramWidth;

void PrintRader()
{
    word vram = Vram + RaderTop * VramRowSize + RaderLeft * VramStep;
    repeat(12) {
        repeat(8) {
            vram = Put(vram, Char_Map);
        }
        vram += VramRowSize - 8 * VramStep;
    }
}

// void DrawFighterOnRader()
// {
//     ShowSprite(
//         Sprite_MapPoint,
//         8 * RaderLeft - 1 + (FighterX >> 1),
//         8 * RaderTop - 1 + (FighterY >> 1), 
//         Pattern_FighterOnMap
//     );
// }
