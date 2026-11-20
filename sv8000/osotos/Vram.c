#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Block.h"

void DrawAll()
{
    EraseSprites();
    DrawBlocks();
    DrawSprites();
    FlushVBuffer();
}

word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}


word Put2CQ(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = VAdd(vram, c);
            ++c;
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}

word Put2SQ(word vram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            vram = VAdd(vram, *pChars);
            ++pChars;
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}

word Erase2Q(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = VAdd(vram, Char_Space);
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}


void Put2CXYOver(byte x, byte y, byte c)
{
    word vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            vram = VAddOver(vram, c);
            ++c;
        }
        vram += VramRowSize - 2;
    }
}