#include "Print.h"
#include "Vram.h"

static bool zeroVisible;
static byte byteValue;
static word wordValue;

static word PrintDigitB(word vram, byte n)
{
    byte c;
    
    c = 0;
    while (byteValue >= n) {
        ++c;
        byteValue -= n;
    }
    if (c == 0) {
        c = zeroVisible ? '0' : ' ';
    }
    else {
        zeroVisible = true;
        c += '0';
    }
    return PrintC(vram, c);
}

word PrintByteNumber3(word vram, byte b)
{
    zeroVisible = false;
    byteValue = b;
    vram = PrintDigitB(vram, 100);
    vram = PrintDigitB(vram, 10);
    vram = PrintC(vram, byteValue + '0');
    return vram;
}

word PrintByteNumber2(word vram, byte b)
{
    zeroVisible = false;
    byteValue = b;
    vram = PrintDigitB(vram, 10);
    vram = PrintC(vram, byteValue + '0');
    return vram;
}


word PrintDigitW(word vram, word n)
{
    byte c;
    
    c = 0;
    while (wordValue >= n) {
        ++c;
        wordValue -= n;
    }
    if (c == 0) {
        c = zeroVisible ? '0' : ' ';
    }
    else {
        zeroVisible = true;
        c += '0';
    }
    return PrintC(vram, c);
}

word PrintNumber5(word vram, word w) {
    zeroVisible = false;
    wordValue = w;
    vram = PrintDigitW(vram, 10000);
    vram = PrintDigitW(vram, 1000);
    vram = PrintDigitW(vram, 100);
    vram = PrintDigitW(vram, 10);
    vram = PrintC(vram, wordValue + '0');
    return vram;
}

word PrintNumber3(word vram, word w) {
    zeroVisible = false;
    wordValue = w;
    vram = PrintDigitW(vram, 100);
    vram = PrintDigitW(vram, 10);
    vram = PrintC(vram, wordValue + '0');
    return vram;
}
