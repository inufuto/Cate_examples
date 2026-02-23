#include "Barrier.h"
#include "Stages.h"
#include "Window.h"
#include "Chars.h"
#include "Sprite.h"
#include "Bang.h"
#include "Main.h"
#include "Mover.h"
#include "Sound.h"

constexpr byte Char_BarrierH0 = Char_Barrier + 0;
constexpr byte Char_BarrierH1 = Char_Barrier + 1;
constexpr byte Char_BarrierV0 = Char_Barrier + 2;
constexpr byte Char_BarrierV1 = Char_Barrier + 3;

constexpr byte Flag_Vertical = 0x01;
constexpr byte Flag_StartOverwrapped = 0x02;
constexpr byte Flag_EndOverwrapped = 0x04;
constexpr byte Flag_StartVisible = 0x10;
constexpr byte Flag_EndVisible = 0x20;
constexpr byte Flag_LineVisible = 0x40;
constexpr byte Flag_Live = 0x80;

constexpr byte Size = 1;

Barrier[MaxBarrierCount] Barriers;


void InitBarriers(ptr<BarrierDef> pDef, byte count)
{
    ptr<Barrier> pBarrier;
    byte i;
    pBarrier = Barriers;

    i = 0;
    while (count != 0 && i < MaxBarrierCount) {
        pBarrier->startX = pDef->x;
        pBarrier->startY = pDef->y;
        pBarrier->flags = pDef->flags | Flag_Live;
        if ((pBarrier->flags & Flag_Vertical) != 0) {
            pBarrier->endX = pBarrier->startX;
            pBarrier->endY = pBarrier->startY + pDef->length;;
        }
        else {
            pBarrier->endX = pBarrier->startX + pDef->length;;
            pBarrier->endY = pBarrier->startY;
        }
        ++pBarrier;
        ++pDef;
        ++i;
        --count;
    }
    while (i < MaxBarrierCount) {
        pBarrier->flags = 0;
        ++pBarrier;
        ++i;
    }
}


static byte DrawHead(byte sprite, byte x, byte y)
{
    if (sprite >= Sprite_EnemyBullet) goto exit;  
    x -= Size;
    y -= Size;
    if (x < WindowWidth * 2 - 2 && y < WindowWidth * 2 - 2) {
        ShowSprite(sprite, x, y, GChar_BarrierHead);
        ++sprite;
    }
exit:
    return sprite;
}

static void HLine(byte x, byte y, byte count, byte c) 
{
    ptr<byte> pWindow;
    pWindow = WindowBack + WindowOffset(x, y);
    while (count != 0) {
        *pWindow = c;
        ++pWindow;
        --count;
    }
}

static void VLine(byte x, byte y, byte count, byte c) 
{
    ptr<byte> pWindow;
    pWindow = WindowBack + WindowOffset(x, y);
    while (count != 0) {
        *pWindow = c;
        pWindow += WindowWidth;
        --count;
    }
}

void DrawBarriers()
{
    ptr<Barrier> pBarrier;
    byte sprite;

    sprite = Sprite_Barrier;
    for (pBarrier: Barriers) {
        byte startX, startY;
        byte endX, endY;

        if ((pBarrier->flags & Flag_Live) == 0) continue;
        pBarrier->flags &= ~(Flag_StartVisible | Flag_EndVisible | Flag_LineVisible);
        
        startX = OffsetX(pBarrier->startX);
        startY = OffsetY(pBarrier->startY);
        if (
            (pBarrier->flags & Flag_StartOverwrapped) == 0 && 
            startX < WindowWidth * 2 && startY < WindowHeight * 2
        ) {
            pBarrier->flags |= Flag_StartVisible;
            sprite = DrawHead(sprite, startX, startY);
        }

        endX = OffsetX(pBarrier->endX);
        endY = OffsetY(pBarrier->endY);
        if (
            (pBarrier->flags & Flag_EndOverwrapped) == 0 && 
            endX < WindowWidth * 2 && endY < WindowHeight * 2
        ) {
            pBarrier->flags |= Flag_EndVisible;
            sprite = DrawHead(sprite, endX, endY);
        }

        if ((pBarrier->flags & Flag_Vertical) != 0) {
            word c;
            c = (startX & 1) == 0 ? Char_BarrierV0 : Char_BarrierV1;
            startX >>= 1;
            if (startX < WindowWidth) {
                startY >>= 1;
                endY = (endY + 1) >> 1;
                if (
                    startY < WindowHeight || 
                    endY < WindowHeight ||
                    pBarrier->startY < BaseY && pBarrier->endY >= BaseY
                ) {
                    if (startY < WindowHeight && endY < WindowHeight && startY > endY) {
                        VLine(startX, 0, endY, c);
                        VLine(startX, startY, WindowHeight - startY, c);
                    }
                    else {
                        if (startY >= WindowHeight) {
                            startY = 0;
                        }
                        if (endY > WindowHeight) {
                            endY = WindowHeight;
                        }
                        VLine(startX, startY, endY - startY, c);
                    }
                    pBarrier->flags |= Flag_LineVisible;
                }
            }
        }
        else {
            word c;
            c = (startY & 1) == 0 ? Char_BarrierH0 : Char_BarrierH1;
            startY >>= 1;
            if (startY < WindowHeight) {
                startX >>= 1;
                endX = (endX + 1) >> 1;
                if (
                    startX < WindowWidth || 
                    endX < WindowWidth ||
                    pBarrier->startX < BaseX && pBarrier->endX >= BaseX
                ) {
                    if (startX < WindowWidth && endX < WindowWidth && startX > endX) {
                        HLine(0, startY, endX, c);
                        HLine(startX, startY, WindowWidth - startX, c);
                    }
                    else {
                        if (startX >= WindowWidth) {
                            startX = 0;
                        }
                        if (endX > WindowWidth) {
                            endX = WindowWidth;
                        }
                        HLine(startX, startY, endX - startX, c);
                    }
                    pBarrier->flags |= Flag_LineVisible;
                }
            }
        }
    }
    while (sprite < Sprite_EnemyBullet) {
        HideSprite(sprite);
        ++sprite;
    }
}

static void DestroyOverwrapped(byte x, byte y)
{
    ptr<Barrier> pBarrier;
    for (pBarrier: Barriers) {
        if ((pBarrier->flags & Flag_Live) == 0) continue;
        if (
            (pBarrier->startX == x && pBarrier->startY == y) ||
            (pBarrier->endX == x && pBarrier->endY == y)
        )
        pBarrier->flags = 0;
    }
}

static void ShowOverwrapped(byte x, byte y) 
{
    ptr<Barrier> pBarrier;
    for (pBarrier: Barriers) {
        if ((pBarrier->flags & Flag_Live) == 0) continue;
        if (pBarrier->startX == x && pBarrier->startY == y) {
            pBarrier->flags &= ~Flag_StartOverwrapped; 
        }
        if (pBarrier->endX == x && pBarrier->endY == y) {
            pBarrier->flags &= ~Flag_EndOverwrapped; 
        }
    }
}

static bool Hit(ptr<Barrier> pBarrier, byte thisX, byte thisY, byte x, byte y, byte size)
{
    if (HitMover(thisX, thisY, Size, x, y, size)) {
        StartBang(thisX, thisY, false);
        Sound_SmallBang();
        pBarrier->flags = 0;
        DestroyOverwrapped(thisX, thisY);
        AddScore(5);
        return true;
    }
    return false;
}


static bool NearBarrier1(ptr<Barrier> pBarrier, byte x, byte y, byte size)
{
    if ((pBarrier->flags & Flag_LineVisible) != 0) {
        if ((pBarrier->flags & Flag_Vertical) != 0) {
            if (x == pBarrier->startX && y > pBarrier->startY && y < pBarrier->endY) {
                return true;
            }
        }
        else {
            if (y == pBarrier->startY && x > pBarrier->startX && x < pBarrier->endX) {
                return true;
            }
        }
    }
    return false;
}

bool NearBarrier(byte x, byte y, byte size)
{
    ptr<Barrier> pBarrier;
    for (pBarrier: Barriers) {
        if ((pBarrier->flags & Flag_Live) == 0) continue;
        if (NearBarrier1(pBarrier, x, y, size)) return true;
    }
    return false;    
}


bool HitBarrier(byte x, byte y, byte size)
{
    ptr<Barrier> pBarrier;
    for (pBarrier: Barriers) {
        if ((pBarrier->flags & Flag_Live) == 0) continue;

        if ((pBarrier->flags & Flag_StartVisible) != 0) {
            if (Hit(pBarrier, pBarrier->startX, pBarrier->startY, x, y, size + Size)) {
                ShowOverwrapped(pBarrier->endX, pBarrier->endY);
                return true;
            }
        }
        if ((pBarrier->flags & Flag_EndVisible) != 0) {
            if (Hit(pBarrier, pBarrier->endX, pBarrier->endY, x, y, size + Size)) {
                ShowOverwrapped(pBarrier->startX, pBarrier->startY);
                return true;
            }
        }
        if (NearBarrier1(pBarrier, x, y, size)) return true;
    }
    return false;
}