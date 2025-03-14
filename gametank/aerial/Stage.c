#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Chars.h"
#include "CopyMemory.h"
#include "Math.h"
#include "Status.h"
#include "Sprite.h"
#include "MyFighter.h"
#include "MyBullet.h"
#include "EnemyFighter.h"
#include "EnemyBullet.h"
#include "GroundEnemy.h"
#include "Fort.h"
#include "Bang.h"
#include "Item.h"

constexpr byte Ground_Flat = 0;
constexpr byte Ground_Up = 1;
constexpr byte Ground_Down = 2;
constexpr byte Ground_Space = 3;

constexpr byte GroundWidth = StageWidth + TileWidth;
constexpr byte Top = 10;
constexpr byte Bottom = StageHeight - 2;

constexpr byte FortStartX = MapWidth * 2 - 10;//5;//

constexpr byte GroundBitsWidth = 9;
constexpr byte GroundBitsHeight = Bottom - Top;

byte[GroundBitsWidth * GroundBitsHeight] GroundBits;
static ptr<Stage> pStage;
static ptr<byte> pGroundByte;
static byte mapX;
static byte mapBits;
byte [GroundWidth] GroundYs;
static byte nextGroundY;
byte MinGroundY;
byte DotOffset;
static byte skyElementCount;
static ptr<SkyElement> pSkyElement;
static byte skyEnemyType;
static byte skyEnemyBit;
static byte groundElementCount;
static ptr<GroundElement> pGroundElement;


static ptr<byte> FillSpaces(ptr<byte> pDestination, byte count)
{
    count -= Top;
    while (count != 0) {
        *pDestination = Ground_Space | (Ground_Space << 2);
        pDestination += GroundBitsWidth;
        --count;
    }
    return pDestination;
}

static ptr<byte> FillGround(ptr<byte> pDestination, byte y) 
{
    while (y < Bottom) {
        *pDestination = Ground_Flat | (Ground_Flat << 2);
        pDestination += GroundBitsWidth;
        ++y;
    }
    return pDestination;
}

static ptr<byte> FillTile(ptr<byte> pDestination, ptr<byte> pSource)
{
    repeat (TileHeight) {
        *pDestination = *pSource;
        ++pSource;
        pDestination += GroundBitsWidth;
    }
    return pDestination;
}


void FillTiles()
{
    static const byte[] UpTile = {
        Ground_Space | (Ground_Up << 2), 
        Ground_Up | (Ground_Flat << 2)
    };
    static const byte[] DownTile = {
        Ground_Down | (Ground_Space << 2), 
        Ground_Flat | (Ground_Down << 2)
    };
    ptr<byte> pDestination, pGroundY;

    if ((mapX & 7) == 0) {
        mapBits = *pGroundByte; 
        ++pGroundByte;
    }
    else {
        mapBits >>= 2;
    }
    pDestination = GroundBits + GroundBitsWidth - 1;
    pGroundY = GroundYs + StageWidth;
    switch (mapBits & 3) {
    case Ground_Up:
        --nextGroundY;
        *pGroundY = nextGroundY;
        ++pGroundY;
        --nextGroundY;
        *pGroundY = nextGroundY;
        pDestination = FillSpaces(pDestination, nextGroundY);
        pDestination = FillTile(pDestination, UpTile);
        FillGround(pDestination, nextGroundY + 2);
        break;
    case Ground_Down:
        pDestination = FillSpaces(pDestination, nextGroundY);
        pDestination = FillTile(pDestination, DownTile);
        *pGroundY = nextGroundY;
        ++nextGroundY;
        *pGroundY = nextGroundY;
        ++nextGroundY;
        FillGround(pDestination, nextGroundY);
        break;
    case Ground_Flat:
        *pGroundY = nextGroundY;
        ++pGroundY;
        *pGroundY = nextGroundY;
        pDestination = FillSpaces(pDestination, nextGroundY);
        FillGround(pDestination, nextGroundY);
        break;
    }
}


void InitStage() 
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

    pGroundByte = pStage->bytes;
    mapX = 0;
    DotOffset = 0;
    nextGroundY = Bottom;
    FillTiles();

    skyElementCount = pStage->skyElementCount;
    pSkyElement = pStage->pSkyElements;
    skyEnemyType = 0;
    skyEnemyBit = 1;
    groundElementCount = pStage->groundElementCount;
    pGroundElement = pStage->pGroundElements;
}


void InitGame()
{
    RndIndex = 0;
    FillMemory(GroundBits, GroundBitsWidth * GroundBitsHeight, 0xff);
    FillMemory(GroundYs, GroundWidth, Bottom);
    InitStage();

    ClearScreen();
    HideAllSprites();
    InitMyFighter();
    InitMyBullets();
    InitEnemyFighters();
    InitEnemyBullets();
    InitGroundEnemies();
    InitForts();
    InitBangs();
    InitItem();
    BackgroundChanged = true;
}


void ScrollBackground()
{
    if (FortCount != 0) return;

    ScrollGroundEnemies();
    ++DotOffset;
    if (DotOffset == CoordRate) {
        DotOffset = 0;
        {
            ptr<byte> pGroundY;
            pGroundY = GroundYs;
            MinGroundY = Bottom;
            repeat(StageWidth) {
                byte h;
                h = pGroundY[1];
                if (h < MinGroundY) {
                    MinGroundY = h;
                }
                pGroundY[0] = h;
                ++pGroundY;
            }
        }
        ShiftGround();
        ++mapX;
        if (mapX == FortStartX && FortCount == 0) {
            StartForts();
        }        
        if (mapX == MapWidth * 2) {
            ++CurrentStage;
            InitStage();
            PrintStage();
        }
        else if ((mapX & 1) == 0) {
            FillTiles();
        }
        {
            constexpr byte Type_Count = 2;
            while (skyElementCount > 0 && pSkyElement->x < mapX) {
                ++pSkyElement;
                --skyElementCount;
            }
            if ((Rnd()) >= CurrentStage + 2) goto next;
            repeat (Type_Count) {
                skyEnemyBit <<= 1;
                ++skyEnemyType;
                if (skyEnemyType >= Type_Count) {
                    skyEnemyType = 0;
                    skyEnemyBit = 1;
                }
                if ((skyEnemyBit & pSkyElement->bits) != 0) break;
            }
            switch (skyEnemyType) {
            case 0:
            case 1:
                StartEnemyFighter(skyEnemyType);
                break;
            }
            next:;
        }
        {
            if (groundElementCount != 0) {
                byte x;
                x = pGroundElement->x + 1;
                if (x == mapX) {
                    StartGroundEnemy(GroundYs[StageWidth + 1], pGroundElement->type);
                    ++pGroundElement;
                    --groundElementCount;
                }
            }
        }
    }
    BackgroundChanged = true;
}


byte GroundY(byte x) 
{
    x = (x + CoordRate / 2) >> CoordShift;
    return GroundYs[x] << CoordShift;
}
