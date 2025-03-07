#include "Fort.h"
#include "Stages.h"
#include "Window.h"
#include "Chars.h"
#include "Bang.h"
#include "Main.h"
#include "Mover.h"
#include "Status.h"
#include "Sound.h"
#include "Vram.h"
#include "Fighter.h"
#include "Sprite.h"
#include "Rader.h"

constexpr byte Size = 6;
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
        pFort->x = pPositions->x >> 1;
        pFort->y = pPositions->y >> 1;
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
        if ((pFort->flags & Flag_Live) == 0)  continue;
        if (pFort->life <= 0) {
            --pFort->life;
            if (pFort->life < -12) {
                pFort->flags = 0;
                --FortCount;
            }
            continue;
        }

        x = OffsetX(pFort->x) - HalfSize;
        y = OffsetY(pFort->y) - HalfSize;
        Put6(x, y, Char_Fort);
        pFort->flags |= Flag_Visible;
    }
}

ptr<Fort> NearFort(byte x, byte y, byte size) 
{
    ptr<Fort> pFort;
    for (pFort : Forts) {
        if ((pFort->flags & (Flag_Live | Flag_Visible)) == 0 || pFort->life <= 0) continue;

        if (HitMover(pFort->x, pFort->y, HalfSize, x, y, size)) {
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
            static const byte[] bytes = { 0xff, 0xff };
            // Sound_LargeBang();
            StartBang(pFort->x, pFort->y, true);
            AddScore(50);
            DrawFighterOnRader();
            DrawFortRader(pFort->x - HalfSize, pFort->y - HalfSize, false);
            DrawFighterOnRader();
        }
        else {
            if (size == 0) {
                ++x;
                ++y;
            }
            // Sound_SmallBang();
            StartBang(x, y, false);
        }
        Sound_Hit();
        WindowChanged = true;
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
