#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVram;


// void Put2S(word offset, ptr<byte> pChars)
// {
//     ptr<byte> pFront, pBack;
//     pFront = VVramFront + offset;
//     pBack = VVramBack + offset;
//     repeat (2) {
//         repeat (2) {
//             byte c;
//             c = *pChars;
//             *pFront = c;
//             *pBack = c;
//             ++pChars;
//             ++pFront;
//             ++pBack;
//         }
//         pFront += VVramWidth - 2;
//         pBack += VVramWidth - 2;
//     }
// }


// void Put2C(byte x, byte y, byte c)
// {
//     word offset;
//     ptr<byte> pFront, pBack;
//     offset = VVramOffset(x, y);
//     pFront = VVramFront + offset;
//     pBack = VVramBack + offset;
//     repeat (2) {
//         repeat (2) {
//             *pFront = c;
//             *pBack = c;
//             ++c;
//             ++pFront;
//             ++pBack;
//         }
//         pFront += VVramWidth - 2;
//         pBack += VVramWidth - 2;
//     }
//     SetRowFlags(y, 3);
// }


void DrawAll()
{
    DrawBackGround();
    DrawSprites();
    VVramToVram();
}
