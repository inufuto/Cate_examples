#include "Sprite.h"
#include "Chars.h"
#include "Vram.h"
#include "VVram.h"
#include "Init.h"

constexpr byte InvalidY = 0x80;
constexpr byte SpriteWidth = 4;
constexpr byte SpriteHeight = 2;

struct Sprite {
    byte x, y;
    byte oldX, oldY;
    byte code;
    byte type;
};

Sprite[SpriteCount] Sprites;

void InitSprites()
{
    HideAllSprites();
}

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->y = InvalidY;
        p->oldY = InvalidY;
    }
}


void ShowSprite(byte index, byte x, byte y, byte code, byte type)
{
    ptr<Sprite> p;
    ptr<byte> pDestination;
    p = Sprites + index;
    p->x = x;
    p->y = y;
    p->code = code;
    p->type = type;
    PollVSync();
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->y = InvalidY;
}


// static ptr<byte> DrawRow(ptr<byte> pVVram, byte code, byte shift)
// {
//     repeat (SpriteWidth) {
//         *pVVram = code; ++pVVram;
//         ++code;
//         *pVVram = shift; ++pVVram;
//     }
//     return pVVram + VVramWidth - SpriteWidth * 2;    
// }

// void DrawSprites()
// {
//     ptr<Sprite> p;
//     for (p : Sprites) {
//         byte y;
//         y = p->y;
//         if (y != InvalidY) {
//             ptr<byte> pVVram, pChar;
//             byte mod, code; 
//             code = p->code;
//             mod = y & 1;
//             y >>= 1;
//             pVVram = VVramFront + VVramOffset(p->x, y);
//             if (p->type == 0) {
//                 if (y < VVramHeight) {
//                     if (mod == 0) {
//                         SetRowFlags(y, 1);
//                         *pVVram = code; ++pVVram;
//                         *pVVram = 0;
//                     }
//                     else {
//                         SetRowFlags(y, 3);
//                         *pVVram = code; ++pVVram;
//                         *pVVram = 1;
//                         pVVram += VVramWidth - 1;
//                         *pVVram = code; ++pVVram;
//                         *pVVram = 3;
//                     }
//                 }
//             }
//             else {
//                 if (mod == 0) {
//                     if (y < VVramHeight) {
//                         SetRowFlags(y, 3);
//                         pVVram = DrawRow(pVVram, code, 0);
//                         code += SpriteWidth;
//                         ++y;
//                         if (y < VVramHeight) {
//                             pVVram = DrawRow(pVVram, code, 0);
//                         }
//                     }
//                 }
//                 else {
//                     if (y < VVramHeight) {
//                         SetRowFlags(y, 7);
//                         if (p->type == 3) {
//                             pVVram = DrawRow(pVVram, code - 4, 2);
//                         }
//                         else {
//                             pVVram = DrawRow(pVVram, code, 1);
//                         }
//                         ++y;
//                         if (y < VVramHeight) {
//                             pVVram = DrawRow(pVVram, code, 2);
//                             code += SpriteWidth;
//                             ++y;
//                             if (y < VVramHeight) {
//                                 pVVram = DrawRow(pVVram, code, p->type == 2 ? 2 : 3);
//                             }
//                         }
//                     }
//                 }
//             }
//         }
//         p->oldX = p->x;
//         p->oldY = p->y;
//     }
// }
