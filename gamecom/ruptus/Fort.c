#include "Fort.h"
#include "Stages.h"
#include "VVram.h"
#include "Chars.h"
#include "Bang.h"
#include "Main.h"
#include "Mover.h"
#include "Sound.h"
#include "Rader.h"

constexpr byte Size2 = 12;
constexpr byte Size = Size2 / 2;
constexpr byte MaxLife = 4;
constexpr byte Flag_Live = 0x80;
constexpr byte Flag_Visible = 0x10;

Fort[MaxFortCount] Forts;
byte FortCount;

void InitForts(ptr<Position> pPositions, byte count)
{
    ptr<Fort> pFort;
    byte i;

    FortCount = count;
    pFort = Forts;
    for (i = 0; i < count; ++i) {
        pFort->x = pPositions->x;
        pFort->y = pPositions->y;
        pFort->life = MaxLife;
        pFort->flags = Flag_Live;
        ++pFort;
        ++pPositions;
    }
    for (i = count; i < MaxFortCount; ++i) {
        pFort->flags = 0;
        ++pFort;
    }
}

void DrawForts() 
{
    ptr<Fort> pFort;

    for (pFort: Forts) {
        sbyte x, y;
        word c;
        if ((pFort->flags & Flag_Live) == 0)  continue;
        if (pFort->life <= 0) {
            --pFort->life;
            if (pFort->life < -12) {
                pFort->flags = 0;
                --FortCount;
            }
            continue;
        }

        pFort->flags &= ~Flag_Visible;
        x = OffsetX(pFort->x) - Size;
        y = OffsetY(pFort->y) - Size;
        if (x < -Size2) continue;
        if (y < -Size2) continue;
        if (x >= VVramWidth * 2) continue;
        if (y >= VVramHeight * 2) continue;
        if ((x & 1) == 0) {
            if ((y & 1) == 0) {
                c = Char_Fort;
            }
            else {
                c = Char_Fort + Size * Size * 2;
            }
        }
        else {
            if ((y & 1) == 0) {
                c = Char_Fort + Size * Size;
            }
            else {
                c = Char_Fort + Size * Size * 3;
            }
        }
        VPut6XY(x >> 1, y >> 1, c);
        pFort->flags |= Flag_Visible;
    }
}

ptr<Fort> NearFort(byte x, byte y, byte size) 
{
    ptr<Fort> pFort;
    for (pFort : Forts) {
        if ((pFort->flags & (Flag_Live | Flag_Visible)) == 0 || pFort->life <= 0) continue;

        if (HitMover(pFort->x, pFort->y, Size, x, y, size)) {
            return pFort;
        }
    }
    return nullptr;
}

bool HitFort(byte x, byte y, byte size) 
{
    ptr<Fort> pFort;
    pFort = NearFort(x, y, size);
    if (pFort != nullptr) {
        --pFort->life;
        if (pFort->life == 0) {
            // Sound_LargeBang();
            DrawFortOnRader(pFort->x, pFort->y, Char_Map);
            StartBang(pFort->x, pFort->y, true);
            AddScore(50);
        }
        else {
            // Sound_SmallBang();
            StartBang(x, y, false);
        }
        Sound_Hit();
        return true;
    }
    return false;
}

void DrawFortsOnRader()
{
    ptr<Fort> pFort;
    for (pFort : Forts) {
        if ((pFort->flags & (Flag_Live | Flag_Visible)) == 0 || pFort->life <= 0) continue;
        DrawFortOnRader(pFort->x, pFort->y, Char_Map + 1);
    }
}
