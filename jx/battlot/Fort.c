#include "Fort.h"
#include "VVram.h"
#include "Chars.h"
#include "Stage.h"
#include "Robo.h"
#include "Bang.h"
#include "Sprite.h"
#include "Sound.h"

constexpr byte MaxLife = 8;
constexpr byte Width = 4;
constexpr byte Height = 3;

Fort MyFort;
Fort EnemyFort;

static void Init(ptr<Fort> pFort, byte position)
{
    pFort->x = (position >> 3) & 0xfe;
    pFort->y = ((position & 15) << 1) + 1;
    pFort->life = MaxLife;
}

void InitMyFort(byte position) 
{
    Init(&MyFort, position);
}

void InitEnemyFort(byte position) 
{
    Init(&EnemyFort, position);
}


static void Draw(ptr<Fort> pFort, byte c)
{
    ptr<byte> pVVram;
    pVVram = VVramPtr(pFort->x, pFort->y + (StageTop - 1));
    {
        byte count, i;
        count = pFort->life >> 1;
        i = 0;
        while (i < count) {
            *pVVram = Char_Meter;
            ++pVVram;
            ++i;
        }
        if ((pFort->life & 1) != 0) {
            *pVVram = Char_Meter + 1;
            ++pVVram;
            ++i;
        }
        while (i < 4) {
            *pVVram = Char_Space;
            ++pVVram;
            ++i;
        }
    }
    if (pFort->life > 0) {
        repeat (Height) {
            pVVram += VVramWidth - Width;
            repeat (Width) {
                *pVVram = c;
                ++pVVram;
                ++c;
            }
        }
    }
    else {
        repeat (Height) {
            pVVram += VVramWidth - Width;
            repeat (Width) {
                *pVVram = Char_Space;
                ++pVVram;
                ++c;
            }
        }
    }
}

void DrawForts()
{
    Draw(&MyFort, Char_MyFort);
    Draw(&EnemyFort, Char_EnemyFort);
}


static bool HitR(ptr<Fort> pFort, byte x, byte y) 
{
    return 
        pFort->life > 0 &&
        x + (RoboSize - 1) >= pFort->x && pFort->x + (Width - 1) >= x &&
        y + (RoboSize - 1) >= pFort->y && pFort->y + (Height - 1) >= y;
}

bool HitMyFortR(byte x, byte y)
{
    return HitR(&MyFort, x, y);
}


bool HitEnemyFortR(byte x, byte y)
{
    return HitR(&EnemyFort, x, y);
}


static bool HitB(ptr<Fort> pFort, byte x, byte y, byte width, byte height) 
{
    return 
        pFort->life > 0 &&
        x + width >= pFort->x && pFort->x + (Width - 1) >= x &&
        y + height >= pFort->y && pFort->y + (Height - 1) >= y;
}

static void Damage(ptr<Fort> pFort, byte x, byte y)
{
    if (pFort->life > 0) {
        --pFort->life;
        DrawForts();
        if (pFort->life == 0) {
            StartBang((pFort->x + 1) << CoordShift, pFort->y << CoordShift, true);
            Sound_LargeBang();
        }
        else {
            StartBang(x << CoordShift, y << CoordShift, false);
            Sound_SmallBang();
        }
    }
}


bool HitMyFortB(byte x, byte y, byte width, byte height, byte side)
{
    if (HitB(&MyFort, x, y, width, height)) {
        if (side != 0 && MyFort.life > 0) {
            Damage(&MyFort, x, y);
            // Sound_Loose();
        }
        return true;
    }
    return false;
}


bool HitEnemyFortB(byte x, byte y, byte width, byte height, byte side)
{
    if (HitB(&EnemyFort, x, y, width, height)) {
        if (side == 0 && EnemyFort.life > 0) {
            Damage(&EnemyFort, x, y);
            // Sound_Hit();
        }
        return true;
    }
    return false;
}
