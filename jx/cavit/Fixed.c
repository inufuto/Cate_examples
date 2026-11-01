#include "Fixed.h"

byte FixedX(byte b)
{
    return (b >> 3) & 0xfe;
}

byte FixedY(byte b)
{
    return ((b & 15) << 1) + 2;
}

ptr<byte> InitFixeds(ptr<Fixed> pObj, byte maxCount, ptr<byte> pStage)
{
    byte count, i;

    count = *pStage;
    ++pStage;

    i = 0;
    while (i < count) {
        byte b;
        b = *pStage;
        ++pStage;
        
        pObj->x = FixedX(b);
        pObj->y = FixedY(b);
        pObj->status = Fixed_Status_Exist;
        ++pObj;
        ++i;
    }
    while (i < maxCount) {
        pObj->status = Fixed_Status_None;
        ++pObj;
        ++i;
    }
    return pStage;
}
