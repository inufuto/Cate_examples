#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Sound.h"

void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
    CallSound();
}


word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}


void Put2(word vram, byte c)
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

void Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            Put(vram, Char_Space);
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}

void Put4(word vram, ptr<byte> pBytes)
{
    repeat(4) {
        repeat(4) {
            Put(vram, *pBytes);
            ++pBytes;
            vram += VramStep;
        }
        vram += VramRowSize - 4 * VramStep;
    }
}