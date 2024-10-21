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

constexpr byte GroundWidth = StageWidth + TileWidth;
constexpr byte GroundHeight = 5;
constexpr byte Bottom = StageHeight - 2;
constexpr byte Top = Bottom - GroundHeight;

constexpr byte FortStartX = MapWidth * 2 - 10;

byte[GroundWidth * GroundHeight] Ground;
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
    while (count != 0) {
        *pDestination = Char_Space;
        ++pDestination;
        *pDestination = Char_Space;
        pDestination += GroundWidth - 1;
        --count;
    }
    return pDestination;
}

static ptr<byte> FillGround(ptr<byte> pDestination, byte y) 
{
    while (y < Bottom) {
        *pDestination = Char_Ground;
        ++pDestination;
        *pDestination = Char_Ground;
        pDestination += GroundWidth - 1;
        ++y;
    }
    return pDestination;
}

static ptr<byte> FillTile(ptr<byte> pDestination, ptr<byte> pSource)
{
    repeat (TileHeight) {
        repeat(TileWidth) {
            *pDestination = *pSource;
            ++pSource;
            ++pDestination;
        }
        pDestination += GroundWidth - TileWidth;
    }
    return pDestination;
}


void FillTiles()
{
    constexpr byte Flat = 0;
    constexpr byte Up = 1;
    constexpr byte Down = 2;
    static const byte[] UpTile = {
        Char_Space, Char_GroundUp, 
        Char_GroundUp, Char_Ground
    };
    static const byte[] DownTile = {
        Char_GroundDown, Char_Space,
        Char_Ground, Char_GroundDown
    };
    ptr<byte> pDestination, pGroundY;

    if ((mapX & 7) == 0) {
        mapBits = *pGroundByte; 
        ++pGroundByte;
    }
    else {
        mapBits >>= 2;
    }
    pDestination = Ground + StageWidth;
    pGroundY = GroundYs + StageWidth;
    switch (mapBits & 3) {
    case Up:
        --nextGroundY;
        *pGroundY = nextGroundY;
        ++pGroundY;
        --nextGroundY;
        *pGroundY = nextGroundY;
        pDestination = FillSpaces(pDestination, nextGroundY - Top);
        // if (pDestination[GroundWidth - 1] == Char_Space) {
        //     pDestination[GroundWidth - 1] = Char_GroundUp;
        // }
        // else if (pDestination[GroundWidth - 1] == Char_GroundDown) {
        //     pDestination[GroundWidth - 1] = Char_GroundDownUp;
        // }
        pDestination = FillTile(pDestination, UpTile);
        FillGround(pDestination, nextGroundY + 2);
        break;
    case Down:
        pDestination = FillSpaces(pDestination, nextGroundY - Top);
        // if (pDestination[-1] == Char_Ground) {
        //     pDestination[-1] = Char_GroundDownDown;
        // }
        // else if (pDestination[-1] == Char_GroundUpUp) {
        //     pDestination[-1] = Char_GroundUpDown;
        // }
        pDestination = FillTile(pDestination, DownTile);
        *pGroundY = nextGroundY;
        ++nextGroundY;
        *pGroundY = nextGroundY;
        ++nextGroundY;
        FillGround(pDestination, nextGroundY);
        break;
    case Flat:
        *pGroundY = nextGroundY;
        ++pGroundY;
        *pGroundY = nextGroundY;
        pDestination = FillSpaces(pDestination, nextGroundY - Top);
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
    FillMemory(Ground, GroundWidth * GroundHeight, Char_Space);
    FillMemory(GroundYs, GroundWidth, Bottom);
    InitStage();

    HideAllSprites();
    UpdateSprites();
    InitMyFighter();
    InitMyBullets();
    InitEnemyFighters();
    InitEnemyBullets();
    InitGroundEnemies();
    InitForts();
    InitBangs();
    InitItem();
    GroundToVram();
    UpdateOffset();
}


void ScrollBackground()
{
    if (FortCount != 0) return;

    ScrollGroundEnemies();
    ++DotOffset;
    if (DotOffset == 8) {
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
        CopyMemory(
            Ground,
            Ground+1,
            GroundWidth * GroundHeight - 1
        );
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
        GroundToVram();
        UpdateOffset();
    }
    else {
        UpdateOffset();        
    }
}


byte GroundY(byte x) 
{
    x = (x + CoordRate / 2) >> CoordShift;
    return GroundYs[x] << CoordShift;
}
