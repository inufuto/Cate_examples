#include "Fort.h"
#include "Stages.h"
#include "Window.h"
#include "Chars.h"
#include "Bang.h"
#include "Main.h"
#include "Mover.h"
#include "Status.h"
#include "Sound.h"
#include "Rader.h"

constexpr byte Size = 12;
constexpr byte HalfSize = Size / 2;
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
        byte c;
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
        x = OffsetX(pFort->x) - HalfSize;
        y = OffsetY(pFort->y) - HalfSize;
        if (x < -Size) continue;
        if (y < -Size) continue;
        if (x >= WindowWidth * 2) continue;
        if (y >= WindowHeight * 2) continue;
        if ((x & 1) == 0) {
            if ((y & 1) == 0) {
                c = Char_Fort;
            }
            else {
                c = Char_Fort + HalfSize * HalfSize * 2;
            }
        }
        else {
            if ((y & 1) == 0) {
                c = Char_Fort + HalfSize * HalfSize;
            }
            else {
                c = Char_Fort + HalfSize * HalfSize * 3;
            }
        }
        Put6(x >> 1, y >> 1, (word)c | (Char_Fort & 0xff00));
        pFort->flags |= Flag_Visible;
    }
}

ptr<Fort> NearFort(byte x, byte y, byte halfSize) 
{
    ptr<Fort> pFort;
    for (pFort : Forts) {
        if ((pFort->flags & (Flag_Live | Flag_Visible)) == 0 || pFort->life <= 0) continue;

        if (HitMover(pFort->x, pFort->y, halfSize, x, y, HalfSize)) {
            return pFort;
        }
    }
    return nullptr;
}

bool HitFort(byte x, byte y, byte halfSize) 
{
    ptr<Fort> pFort;
    pFort = NearFort(x, y, halfSize);
    if (pFort != nullptr) {
        --pFort->life;
        if (pFort->life == 0) {
            Sound_LargeBang();
            StartBang(pFort->x, pFort->y, true);
            AddScore(50);
            DrawFighterOnRader();
            DrawFortRader(pFort->x - HalfSize, pFort->y - HalfSize, false);
            DrawFighterOnRader();
        }
        else {
            Sound_SmallBang();
            StartBang(x, y, false);
        }
        return true;
    }
    return false;
}

void DrawFortsOnRader()
{
    ptr<Fort> pFort;
    for (pFort : Forts) {
        if ((pFort->flags & (Flag_Live | Flag_Visible)) == 0 || pFort->life <= 0) continue;
        DrawFortRader(pFort->x - HalfSize, pFort->y - HalfSize, true);
    }
}
