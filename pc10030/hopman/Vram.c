#include "Vram.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"
#include "Sound.h"

// extern byte[] MonoPatternSource, LinePatternSource, ColorPatternSource, SpritePatternSource;
// constexpr byte SourceCharSize = 8 * 3;
// constexpr byte FortSize = 6;

// byte[48 * Char_End] CharPattern;
// byte[256 * Pattern_End] SpritePattern;

// // static ShiftedChars


// void InitVram()
// {
//     byte[FortSize * (FortSize + 1) * 24] ShiftedPattern;

//     ClearScreen();
//     MakePatternMono(Char_Ascii, MonoPatternSource + Char_Ascii * CharHeight, 64, 0x07);
//     MakePatternMono(Char_Logo, MonoPatternSource + Char_Logo * CharHeight, 16 + 8 + 1, 0x05);
//     MakePatternMono(Char_Ladder, MonoPatternSource + Char_Ladder * CharHeight, 2 + 4, 0x06);
//     MakePatternColor(Char_Remain, ColorPatternSource, Char_End - Char_Remain);
//     MakeSpritePattern(SpritePatternSource, Pattern_End);
// }

word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            Put(vram, c);
            ++c;
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
