#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Init.h"

extern byte[] SpritePattern;

constexpr byte InvalidCode = 0;

struct Size {
    byte size;
    byte offsetH;
    byte offsetV;
    byte offsetHV;
};
static const Size[] Sizes = {
    { 1, 1, 3, 5 },
    { 2, 4, 10, 16 },
    { 4, 16, 36, 56 },
};


Sprite[SpriteCount] Sprites;


static word WriteSpritePattern(word c, ptr<byte> pSource, byte size, byte add) 
{
    {
        ptr<byte> p;
        byte xCount, yCount;
        p = pSource;
        yCount = size;
        do {
            xCount = size;
            do {
                WritePattern(c, p);
                ++c;
                p += PatternSize;
                --xCount;
            } while (xCount != 0);
            --yCount;
        } while (yCount != 0);
    } 
    {
        ptr<byte> p;
        byte xCount, yCount;
        p = pSource;
        yCount = size;
        do {
            xCount = size;
            do {
                WritePatternH(c, p);
                ++c;
                p += PatternSize;
                --xCount;
            } while (xCount != 0);
            c += add;
            --yCount;
        } while (yCount != 0);
    } 
    {
        ptr<byte> p;
        byte xCount, yCount;
        p = pSource;
        yCount = size;
        do {
            xCount = size;
            do {
                WritePatternV(c, p, size);
                ++c;
                p += PatternSize;
                --xCount;
            } while (xCount != 0);
            --yCount;
        } while (yCount != 0);
        xCount = size;
        do {
            c += add;
            --xCount;
        } while (xCount != 0);
    } 
    {
        ptr<byte> p;
        byte xCount, yCount;
        p = pSource;
        yCount = size;
        do {
            xCount = size;
            do {
                WritePatternHV(c, p, size + add);
                ++c;
                p += PatternSize;
                --xCount;
            } while (xCount != 0);
            c += add;
            --yCount;
        } while (yCount != 0);
        xCount = size;
        do {
            c += add;
            --xCount;
        } while (xCount != 0);
        c += add;
    }
    return c;
}


void InitSprites()
{
    ptr<byte> pSource;
    word c;

    ClearSpriteRam();

    pSource = SpritePattern;
    c = 0;
    WritePattern(c, pSource);
    ++c;
    pSource += PatternSize;
    repeat (3) {
        c = WriteSpritePattern(c, pSource, 1, 1);
        pSource += PatternSize;
    }  
    repeat (15) {
        c = WriteSpritePattern(c, pSource, 2, 1);
        pSource += PatternSize * 2 * 2;
    } 
    c = WriteSpritePattern(c, pSource, 4, 1);

    HideAllSprites();
}


void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->code = InvalidCode;
        p->oldCode = InvalidCode;
    }
    ClearGVVram();
}


void ShowSprite(byte index, byte x, byte y, word code)
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->x = x;
    p->y = y;
    p->code = code;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->code = InvalidCode;
}

static ptr<Size> Size(word code)
{
    if (code < GChar_Fighter) {
        return Sizes + 0;
    }
    if (code < GChar_LargeBang) {
        return Sizes + 1;
    }
    return Sizes + 2;
}


static void Erase(byte x, byte y, byte width, byte height)
{
    ptr<word> pRow;
    byte yy, bits;
    pRow = GVVram + VVramOffset(x, y);
    yy = y;
    bits = 0;
    do {
        ptr<word> p;
        byte xx, count;
        if (yy >= VVramHeight) break;
        p = pRow;
        count = width;
        xx = x;
        do {
            if (x < VVramWidth) {
                *p = 0;
            }
            ++p;
            ++xx;
            --count;
        } while (count != 0);
        pRow += VVramWidth;
        bits = (bits << 1) | 1;
        ++yy;
        --height;
    } while (height != 0);
    SetGRowFlags(y, bits);
    PollVSync();
}

static void Draw(sbyte x, sbyte y, word code, sbyte width, sbyte height, bool changed)
{
    ptr<word> pRow;
    byte yy, bits;
    pRow = GVVram + VVramOffset(x, y);
    yy = y;
    bits = 1;
    do {
        ptr<word> p;
        byte xx, count;
        if (yy >= VVramHeight) break;
        p = pRow;
        count = width;
        xx = x;
        do {
            if (xx < VVramWidth) {
                *p = code;
            }
            ++p;
            ++code;
            --count;
        } while (count != 0);
        pRow += VVramWidth;
        bits = (bits << 1) | 1;
        ++yy;
        --height;
    } while (height != 0);
    if (changed) {
        SetGRowFlags(y, bits);
    }
    PollVSync();
}

void EraseSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->oldCode != InvalidCode && (
                p->oldX != p->x || 
                p->oldY != p->y ||
                p->code == InvalidCode
        )) {
            byte x, y, width, height;
            ptr<Size> pSize;
            x = p->oldX;
            y = p->oldY;
            pSize = Size(p->oldCode);
            width = height = pSize->size;
            if ((x & 1) != 0) {
                ++width;
            }
            if ((y & 1) != 0) {
                ++height;
            }
            Erase(x >> 1, y >> 1, width, height);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            byte x, y,  width, height, iy;
            ptr<Size> pSize;
            word code;
            bool changed;
            x = p->x;
            y = p->y;
            code = p->code;
            pSize = Size(p->code);
            width = height = pSize->size;
            changed = p->oldX != x || p->oldY != y || p->oldCode != code;
            if ((x & 1) != 0) {
                ++width;
                if ((y & 1) != 0) {
                    ++height;
                    code += pSize->offsetHV;
                }
                else {
                    code += pSize->offsetH;
                }
            } else {
                if ((y & 1) != 0) {
                    ++height;
                    code += pSize->offsetV;
                }
            }
            Draw(x >> 1, y >> 1, code, width, height, changed);
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
