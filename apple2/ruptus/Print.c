#include "Print.h"
#include "Vram.h"

static bool zeroVisible;
static byte byteValue;
static word wordValue;

static void PrintDigitB(byte n)
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
    PrintC(c);
}

void PrintByteNumber3(byte b)
{
    zeroVisible = false;
    byteValue = b;
    PrintDigitB(100);
    PrintDigitB(10);
    PrintC(byteValue + '0');
    
}

void PrintByteNumber2(byte b)
{
    zeroVisible = false;
    byteValue = b;
    PrintDigitB(10);
    PrintC(byteValue + '0');
    
}


void PrintDigitW(word n)
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
    PrintC(c);
}

void PrintNumber5(word w) {
    zeroVisible = false;
    wordValue = w;
    PrintDigitW(10000);
    PrintDigitW(1000);
    PrintDigitW(100);
    PrintDigitW(10);
    PrintC(wordValue + '0');
    
}

void PrintNumber3(word w) {
    zeroVisible = false;
    wordValue = w;
    PrintDigitW(100);
    PrintDigitW(10);
    PrintC(wordValue + '0');
    
}
