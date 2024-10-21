#include "Scroll.h"

const byte[] ScrollPositions = {
    0,1,1,2,3,4,4,5,6,7,7,8,9,9,10,11,12,12,13,14,15,15,16,17,17,18,19,20,20,21,22,23,23,24,25,25,26,27,28,28,29,30,31,31,32
};
byte HScroll;
byte ScrollTarget;

void UpdateScroll()
{
    if (HScroll > ScrollTarget) {
        --HScroll;
    }
    else if (HScroll < ScrollTarget) {
        ++HScroll;
    }
}
