#include "Print.h"
#include "Vram.h"

static bool zeroVisible;
static byte byteValue;
static word wordValue;

static ptr<byte> PrintDigitB(ptr<byte> pVram, byte n)
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
    return PrintC(pVram, c);
}

ptr<byte> PrintByteNumber3(ptr<byte> pVram, byte b)
{
    zeroVisible = false;
    byteValue = b;
    pVram = PrintDigitB(pVram, 100);
    pVram = PrintDigitB(pVram, 10);
    pVram = PrintC(pVram, byteValue + '0');
    return pVram;
}

ptr<byte> PrintByteNumber2(ptr<byte> pVram, byte b)
{
    zeroVisible = false;
    byteValue = b;
    pVram = PrintDigitB(pVram, 10);
    pVram = PrintC(pVram, byteValue + '0');
    return pVram;
}


ptr<byte> PrintDigitW(ptr<byte> pVram, word n)
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
    return PrintC(pVram, c);
}

ptr<byte> PrintNumber5(ptr<byte> pVram, word w) {
    zeroVisible = false;
    wordValue = w;
    pVram = PrintDigitW(pVram, 10000);
    pVram = PrintDigitW(pVram, 1000);
    pVram = PrintDigitW(pVram, 100);
    pVram = PrintDigitW(pVram, 10);
    pVram = PrintC(pVram, wordValue + '0');
    return pVram;
}

ptr<byte> PrintNumber3(ptr<byte> pVram, word w) {
    zeroVisible = false;
    wordValue = w;
    pVram = PrintDigitW(pVram, 100);
    pVram = PrintDigitW(pVram, 10);
    pVram = PrintC(pVram, wordValue + '0');
    return pVram;
}
