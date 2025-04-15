#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Status.h"
#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"
#include "Man.h"
#include "Box.h"
#include "Rock.h"
#include "Chaser.h"
#include "Ghost.h"
#include "Direction.h"
#include "Point.h"
#include "VVram.h"

const byte[] WallBits = {
    Wall_Right, Wall_Left, Wall_Bottom, Wall_Top
};

byte[MapWidth * MapHeight] TerrainMap;
ptr<byte> pStage;


byte CurrentTerrain(byte x, byte y)
{
    if (x < MapWidth && y < MapHeight) {
        return *TerrainMapPtr(x, y);
    }
    return Terrain_Wall;
}

void DrawTerrain(byte x, byte y, byte terrain)
{
    byte t;
    ptr<byte> pChars;

    t = terrain & Terrain_Mask;
    if (t == Terrain_Space) {
        static const byte[] Codes = {
            Char_Wall_Space, Char_Wall_Space, Char_Wall_Space, Char_Wall_Space, 
            Char_Wall_Left, Char_Wall_Space, Char_Wall_Left, Char_Wall_Space, 
            Char_Wall_Space, Char_Wall_Right, Char_Wall_Space, Char_Wall_Right, 
            Char_Wall_Left, Char_Wall_Right, Char_Wall_Left, Char_Wall_Right, 
            Char_Wall_Top, Char_Wall_Top, Char_Wall_Space, Char_Wall_Space, 
            Char_Wall_LeftTop, Char_Wall_Top, Char_Wall_Left, Char_Wall_Space, 
            Char_Wall_Top, Char_Wall_RightTop, Char_Wall_Space, Char_Wall_Right, 
            Char_Wall_LeftTop, Char_Wall_RightTop, Char_Wall_Left, Char_Wall_Right, 
            Char_Wall_Space, Char_Wall_Space, Char_Wall_Bottom, Char_Wall_Bottom, 
            Char_Wall_Left, Char_Wall_Space, Char_Wall_LeftBottom, Char_Wall_Bottom, 
            Char_Wall_Space, Char_Wall_Right, Char_Wall_Bottom, Char_Wall_RightBottom, 
            Char_Wall_Left, Char_Wall_Right, Char_Wall_LeftBottom, Char_Wall_RightBottom, 
            Char_Wall_Top, Char_Wall_Top, Char_Wall_Bottom, Char_Wall_Bottom, 
            Char_Wall_LeftTop, Char_Wall_Top, Char_Wall_LeftBottom, Char_Wall_Bottom, 
            Char_Wall_Top, Char_Wall_RightTop, Char_Wall_Bottom, Char_Wall_RightBottom, 
            Char_Wall_LeftTop, Char_Wall_RightTop, Char_Wall_LeftBottom, Char_Wall_RightBottom, 
        };
        pChars = Codes +((terrain >> 2) & 0x3c);
    }
    else {
        static const byte[] Codes = {
            Char_Soil, Char_Soil + 1, Char_Soil + 1, Char_Soil,
            Char_Bedrock, Char_Bedrock, Char_Bedrock, Char_Bedrock,
            0,0,0,0,
        };
        pChars = Codes + ((t - 1) << 2);
    }
    DrawTerrainBytes(x, y, pChars);
}


void DrawTerrainBytes(byte x, byte y, ptr<byte> pChars)
{
    word offset;
    ptr<byte> pBack, pFront;
    offset = VVramOffset(x << 1, y << 1);
    pBack = VVramBack + offset;
    pFront = VVramFront + offset;
    repeat (2) {
        repeat (2) {
            byte c;
            c = *pChars;
            if (*pBack != c) {
                *pBack = c;
                *pFront = c;
            }
            ++pChars;
            ++pBack;
            ++pFront;
        }
        pBack += VVramWidth - 2;
        pFront += VVramWidth - 2;
    }
}


void InitStage() 
{
    ptr< ptr<byte> > pp;
    byte i, j;
    i = 0;
    j = 0;
    pp = Stages;
    while (i < CurrentStage) {
        ++pp;
        ++i;
        ++j;
        if (j >= StageCount) {
            pp = Stages;
            j = 0;
        }
    }
    pStage = *pp;
}

void InitTrying()
{
    ptr<byte> p;

    p = pStage;
    StageTime = 100;
    ClearScreen();
    HideAllSprites();
    PrintStatus();
    ClearVVram();
    {
        ptr<byte> pTerrain;
        pTerrain = TerrainMap;
        repeat (MapWidth) {
            *pTerrain = Terrain_Space;
            ++pTerrain;
        }
        repeat (MapHeight - 1) {
            repeat (MapWidth / 4) {
                byte b;
                b = *p;
                ++p;
                repeat (4) {
                    *pTerrain = b & 3;
                    ++pTerrain;
                    b >>= 2;
                }
            }
        }
    }
    p = InitBoxes(p);
    p = InitRocks(p);
    p = InitChasers(p);
    p = InitGhosts(p);
    {
        byte y;
        ptr<byte> pTerrain;
        pTerrain = TerrainMap + MapWidth;
        y = 1;
        repeat (MapHeight - 1) {
            byte x;
            x = 0;
            repeat (MapWidth) {
                byte terrain;
                terrain = *pTerrain;
                if (terrain == Terrain_Space) {
                    if (y > 1 && (pTerrain[-MapWidth] & Terrain_Mask) != Terrain_Space) {
                        terrain |= Wall_Top;
                    }
                    if (
                        y >= MapHeight - 1 || 
                        (pTerrain[MapWidth] & Terrain_Mask) != Terrain_Space
                    ) {
                        terrain |= Wall_Bottom;
                    }
                    if (
                        x < 1 || 
                        (pTerrain[-1] & Terrain_Mask) != Terrain_Space
                    ) {
                        terrain |= Wall_Left;
                    }
                    if (
                        x > MapWidth - 1 || 
                        (pTerrain[1] & Terrain_Mask) != Terrain_Space
                    ) {
                        terrain |= Wall_Right;
                    }
                }
                else {
                    terrain |= Wall_All;
                }
                *pTerrain = terrain;
                DrawTerrain(x, y, terrain);
                ++pTerrain;
                ++x;
            }
            ++y;
        }
    }
    DrawBoxes();
    DrawRocks();
    InitPoints();
    StartChasers();
    StartGhosts();
    StartMan();
    // UpdateSprites();
    DrawAll();
}
