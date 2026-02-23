#include "Sprite.h"
#include "Window.h"
#include "Vram.h"
#include "Chars.h"
#include "Sound.h"

constexpr byte InvalidCode = 0;
Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->code = InvalidCode;
        p->oldCode = InvalidCode;
    }
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

static word Size(word code)
{
    if (code < GChar_Fighter) {
        return 1;
    }
    if (code < GChar_LargeBang) {
        return 2;
    }
    return 4;
}


static void Erase(sbyte x, sbyte y, sbyte width, sbyte height)
{
    ptr<word> pRow;

    if (x <= -width) return;
    if (x >= WindowWidth) return;
    if (y <= -height) return;
    if (y >= WindowHeight) return;

    if (x >= WindowWidth - width) {
        width = WindowWidth - x;
    }
    else if (x < 0) {
        width += x;
        x = 0;
    }
    if (y >= WindowHeight - height) {
        height = WindowHeight - y;
    }
    else while (y < 0) {
        --height;
        ++y;
    }

    pRow = WindowFront + WindowOffset(x, y);
    do {
        ptr<word> p;
        byte count;
        p = pRow;
        count = width;
        do {
            *p = 0;
            ++p;
            --count;
        } while (count != 0);
        pRow += WindowWidth;
        SetRowFlag(y);
        ++y;
        --height;
    } while (height != 0);
    CallSound();
}

static void Draw(sbyte x, sbyte y, word code, sbyte width, sbyte height, bool changed)
{
    byte charStep;
    ptr<word> pRow;

    if (x <= -width) return;
    if (x >= WindowWidth) return;
    if (y <= -height) return;
    if (y >= WindowHeight) return;

    charStep = width;
    if (x >= WindowWidth - width) {
        width = WindowWidth - x;
    }
    else if (x < 0) {
        width += x;
        code += -x;
        x = 0;
    }
    if (y >= WindowHeight - height) {
        height = WindowHeight - y;
    }
    else while (y < 0) {
        --height;
        ++y;
        code += charStep;
    }

    pRow = WindowFront + WindowOffset(x, y);
    do {
        ptr<word> p;
        word c;
        byte count;
        p = pRow;
        count = width;
        c = code;
        do {
            *p = c;
            ++p;
            ++c;
            --count;
        } while (count != 0);
        pRow += WindowWidth;
        code += charStep;
        if (changed) {
            SetRowFlag(y);
        }
        ++y;
        --height;
    } while (height != 0);
    CallSound();
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
            x = p->oldX;
            y = p->oldY;
            width = height = Size(p->oldCode);
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


bool DrawSprites()
{
    bool changedAny;
    ptr<Sprite> p;
    changedAny = false;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            byte x, y, size, width, height, iy;
            word code;
            bool changed;
            x = p->x;
            y = p->y;
            code = p->code;
            size = Size(p->code);
            changed = p->oldX != x || p->oldY != y || p->oldCode != code;
            if ((x & 1) != 0) {
                width = size + 1;
                if ((y & 1) != 0) {
                    height = size + 1;
                    switch (size) {
                    case 1:
                        code += 5;
                        break;
                    case 2:
                        code += 16;
                        break;
                    default:
                        code += 56;
                    }
                }
                else {
                    height = size;
                    switch (size) {
                    case 1:
                        code += 1;
                        break;
                    case 2:
                        code += 4;
                        break;
                    default:
                        code += 16;
                    }
                }
            } else {
                width = size;
                if ((y & 1) != 0) {
                    height = size + 1;
                    switch (size) {
                    case 1:
                        code += 3;
                        break;
                    case 2:
                        code += 10;
                        break;
                    default:
                        code += 36;
                    }
                }
                else {
                    height = size;
                }
            }
            Draw(x >> 1, y >> 1, code, width, height, changed);
            if (changed) {
                changedAny = true;
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
    return changedAny;
}
