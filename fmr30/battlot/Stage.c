#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
#include "Fort.h"
#include "Robo.h"
#include "Bullet.h"
#include "Bang.h"
#include "VVram.h"

constexpr byte WallMapWidth = StageWidth / 4;
static ptr<Stage> pStage;
byte[WallMapWidth * StageHeight] WallMap;

void InitStage()
{
    HideAllSprites();
    // UpdateSprites();
    ClearScreen();
    {
        byte i, j;
        i = 0;
        j = 0;
        pStage = Stages;
        while (i < CurrentStage) {
            ++pStage;
            ++i;
            ++j;
            if (j >= StageCount) {
                pStage = Stages;
                j = 0;
            }
        }
    }
    InitEnemyFort(pStage->enemyFort);
}


void InitTrying()
{
    StageTime = 120;
    HideAllSprites();
    // UpdateSprites();
    ClearScreen();
    {
        ptr<byte> pBytes;
        byte y;
        pBytes = pStage->bytes;
        y = 0;
        repeat (MapHeight) {
            byte x;
            x = 0;
            repeat (MapWidth / 4) {
                byte sourceByte, wallByte, wallCount;
                sourceByte = *pBytes;
                repeat (4) {
                    byte bits;
                    bits = sourceByte & Wall_Hard;
                    repeat (2) {
                        SetWall(x, y, bits);
                        SetWall(x, y + 1, bits);
                        ++x;
                    }
                    sourceByte >>= 2;
                }
                ++pBytes;
            }
            y += 2;
        }
    }
    InitMyFort(pStage->myFort);
    RoboStartIndex = 0;
    StartMyRobo(Robo_Status_Live);
    InitEnemyRobos();
    IntBullets();
    InitBangs();
    DrawForts();
}


static ptr<byte> WallMapPtr(byte x, byte y)
{
    return WallMap + ((y << 3) + (x >> 2));
}

byte GetWall(byte x, byte y)
{
    byte xMod, b;
    b = *WallMapPtr(x, y);
    xMod = x & 3;
    if (xMod != 0) {
        do {
            b >>= 2;
            --xMod;
        } while (xMod != 0);
    }
    return b & Wall_Hard;
}


void SetWall(byte x, byte y, byte wall)
{
    {
        byte c;
        c = wall == 0 ? Char_Space : wall + (Char_Wall - 1);
        *VVramPtr(x, y + StageTop) = c;
    }
    {
        ptr<byte> pWall;
        byte xMod, mask;
        pWall = WallMapPtr(x, y);
        mask = 0xfc;
        xMod = x & 3;
        if (xMod != 0) {
            do {
                wall <<= 2;
                mask = (mask << 2) | 3;
                --xMod;
            } while (xMod != 0);
        }
        *pWall = (*pWall & mask) | wall;
    }
}
