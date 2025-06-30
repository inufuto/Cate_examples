#include "Barrier.h"
#include "Stages.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Bang.h"
#include "Main.h"
#include "Mover.h"
#include "Sound.h"
#include "Vram.h"

constexpr byte Flag_Vertical = 0x01;
constexpr byte Flag_StartOverwrapped = 0x02;
constexpr byte Flag_EndOverwrapped = 0x04;
constexpr byte Flag_StartVisible = 0x10;
constexpr byte Flag_EndVisible = 0x20;
constexpr byte Flag_LineVisible = 0x40;
constexpr byte Flag_Live = 0x80;

Barrier[MaxBarrierCount] Barriers;


void InitBarriers(ptr<BarrierDef> pDef, byte count)
{
    ptr<Barrier> pBarrier;
    byte i;
    pBarrier = Barriers;

    i = 0;
    while (count != 0 && i < MaxBarrierCount) {
        pBarrier->startX = pDef->x >> 1;
        pBarrier->startY = pDef->y >> 1;
        pBarrier->flags = pDef->flags | Flag_Live;
        if ((pBarrier->flags & Flag_Vertical) != 0) {
            pBarrier->endX = pBarrier->startX;
            pBarrier->endY = pBarrier->startY + (pDef->length >> 1);
        }
        else {
            pBarrier->endX = pBarrier->startX + (pDef->length >> 1);
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


void HLine(byte x, byte y, byte count) 
{
    ptr<byte> pVVram;
    pVVram = VVramPtr(x, y);
    while (count != 0) {
        *pVVram = Char_Barrier;
        ++pVVram;
        --count;
    }
}

static void VLine(byte x, byte y, byte count) 
{
    ptr<byte> pVVram;
    pVVram = VVramPtr(x, y);
    while (count != 0) {
        *pVVram = Char_Barrier + 1;
        pVVram += VVramWidth;
        --count;
    }
}

void DrawBarriers()
{
    ptr<Barrier> pBarrier;
    for (pBarrier: Barriers) {
        byte startX, startY;
        byte startXHalf, startYHalf;
        byte endX, endY;
        byte endXHalf, endYHalf;

        if ((pBarrier->flags & Flag_Live) == 0) continue;
        pBarrier->flags &= ~(Flag_StartVisible | Flag_EndVisible | Flag_LineVisible);
        
        startX = OffsetX(pBarrier->startX);
        startY = OffsetY(pBarrier->startY);
        if (
            (pBarrier->flags & Flag_StartOverwrapped) == 0 && 
            startX < VVramWidth && startY < VVramHeight
        ) {
            pBarrier->flags |= Flag_StartVisible;
            *VVramPtr(startX, startY) = Char_BarrierHead;
        }

        endX = OffsetX(pBarrier->endX);
        endY = OffsetY(pBarrier->endY);
        if (
            (pBarrier->flags & Flag_EndOverwrapped) == 0 && 
            endX < VVramWidth && endY < VVramHeight
        ) {
            pBarrier->flags |= Flag_EndVisible;
            *VVramPtr(endX, endY) = Char_BarrierHead;
        }

        if ((pBarrier->flags & Flag_Vertical) != 0) {
            ++startY;
            if (startX < VVramWidth) {
                if (
                    startY < VVramHeight || endY < VVramHeight ||
                    pBarrier->startY < BaseY && pBarrier->endY >= BaseY
                ) {
                    if (startY < VVramHeight && endY < VVramHeight && startY > endY) {
                        VLine(startX, 0, endY);
                        VLine(startX, startY, VVramHeight - startY);
                    }
                    else {
                        if (startY >= VVramHeight) {
                            startY = 0;
                        }
                        if (endY > VVramHeight) {
                            endY = VVramHeight;
                        }
                        VLine(startX, startY, endY - startY);
                    }
                    pBarrier->flags |= Flag_LineVisible;
                }
            }
        }
        else {
            ++startX;
            if (startY < VVramHeight) {
                if (
                    startX < VVramWidth || endX < VVramWidth ||
                    pBarrier->startX < BaseX && pBarrier->endX >= BaseX
                ) {
                    if (startX < VVramWidth && endX < VVramWidth && startX > endX) {
                        HLine(0, startY, endX);
                        HLine(startX, startY, VVramWidth - startX);
                    }
                    else {
                        if (startX >= VVramWidth) {
                            startX = 0;
                        }
                        if (endX > VVramWidth) {
                            endX = VVramWidth;
                        }
                        HLine(startX, startY, endX - startX);
                    }
                    pBarrier->flags |= Flag_LineVisible;
                }
            }
        }
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
    if (HitMover(thisX, thisY, 0, x, y, size)) {
        StartBang(thisX, thisY, false);
        Sound_SmallBang();
        // Sound_Hit();
        pBarrier->flags = 0;
        DestroyOverwrapped(thisX, thisY);
        AddScore(5);
        VVramChanged = true;
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
            if (Hit(pBarrier, pBarrier->startX, pBarrier->startY, x, y, size)) {
                ShowOverwrapped(pBarrier->endX, pBarrier->endY);
                return true;
            }
        }
        if ((pBarrier->flags & Flag_EndVisible) != 0) {
            if (Hit(pBarrier, pBarrier->endX, pBarrier->endY, x, y, size)) {
                ShowOverwrapped(pBarrier->startX, pBarrier->startY);
                return true;
            }
        }
        if (NearBarrier1(pBarrier, x, y, size)) return true;
    }
    return false;
}