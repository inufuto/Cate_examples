#include "Man.h"
#include "Movable.h"
#include "Sprite.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Direction.h"
#include "VVram.h"
#include "Rock.h"
#include "Sound.h"

constexpr byte Size = 2;
constexpr byte StartX = StageWidth - Size;

const byte[] ManChars = {
    0x3b, 0x7b, 0xf6, 0xf4, 0x3b, 0x7b, 0xfa, 0x00,
	0x3b, 0x7b, 0xf8, 0xf9, 0x3b, 0x7b, 0x00, 0xf5,
	0x3a, 0xf6, 0x7a, 0xf2, 0x3a, 0xfc, 0x7a, 0x00,
	0x3a, 0xf8, 0x7a, 0xf9, 0x3a, 0x00, 0x7a, 0xf3,
};

Movable man;
static byte prevMapX, prevMapY;
static byte nextMapX, nextMapY;
// static byte charOffset;

static const byte[] KeyCodes = {
    Keys_Right, Keys_Left, Keys_Down, Keys_Up
};

static const byte[] MidChars = {
    Char_Wall_RightTop, Char_Soil1, Char_Wall_RightBottom, Char_Soil0, 
    Char_Soil0, Char_Wall_LeftTop, Char_Soil1, Char_Wall_LeftBottom, 
    Char_Wall_LeftBottom, Char_Wall_RightBottom, Char_Soil1, Char_Soil0, 
    Char_Soil0, Char_Soil1, Char_Wall_LeftTop, Char_Wall_RightTop, 
};

static void Draw()
{
    byte c = ((man.status & Movable_Direction_Mask) << 2);
    c += ((man.x + man.y) << 2) & 4;
    ShowSprite(&man, ManChars + c);
}

void StartMan()
{
    man.x = StartX;
    man.y = 0;
    man.sprite = Sprite_Man;
    man.status = Movable_Status_Live | Direction_Left;
    // charOffset = 0;
    man.step = 0;
    Draw();
}


static byte MakeNext(byte direction)
{
    SetDirection(&man, direction);
    nextMapX = prevMapX + man.dx;
    nextMapY = prevMapY + man.dy;
    return CurrentTerrain(nextMapX, nextMapY);
}


static bool IsNearAny()
{
    return IsNearRock(&man, man.x + (man.dx << MapShift), man.y + (man.dy << MapShift));
}

void MoveMan()
{
    if (
        (man.step & Movable_Status_CanMove) == 0 &&
        ((man.x | man.y) & MapMask) == 0
    ) {
        byte key, direction;
        ptr<byte> pKeyCode;
        key = ScanKeys();
        direction = 0;
        for (pKeyCode: KeyCodes) {
            if ((key & *pKeyCode) != 0) goto keyOn;
            direction += 2;
        }
        man.status &= ~Movable_Status_CanMove;
        return;

        keyOn:
        {
            byte next;
            prevMapX = man.x >> MapShift;
            prevMapY = man.y >> MapShift;
            next = MakeNext(direction) & Terrain_Mask;
            if (next >= Terrain_Wall || IsNearAny()) {
                byte oldDirection;
                oldDirection = man.status & Movable_Direction_Mask;
                next = MakeNext(oldDirection) & Terrain_Mask;
                if (next >= Terrain_Wall || IsNearAny()) {
                    man.status &= ~Movable_Status_CanMove;
                    goto draw;
                }
            }
            {
                // charOffset = 
                //     next == 0 &&
                //     (*TerrainMapPtr(prevMapX, prevMapY) & WallBits[direction >> 1]) == 0 
                //     ? 0 : 32;
                man.status |= Movable_Status_CanMove;
            }
        }
    }
    if (MoveMovable(&man)) {
        if (((man.x | man.y) & MapMask) == 0) {
            ptr<byte> pNext;
            byte next;
            pNext = TerrainMapPtr(nextMapX, nextMapY);
            next = *pNext;
            next &= ~Terrain_Mask;
            *pNext = next;
            HitBox();
            DrawTerrain(nextMapX, nextMapY, next);
        }
        else {
            ptr<byte> pPrev, pNext;
            byte direction, prev, next;
            pPrev = TerrainMapPtr(prevMapX, prevMapY);
            direction = man.status & Movable_Direction_Mask;
            
            prev = *pPrev;
            prev &= ~WallBits[direction >> 1];
            *pPrev = prev;
            DrawTerrain(prevMapX, prevMapY, prev);
            
            pNext = TerrainMapPtr(nextMapX, nextMapY);
            next = *pNext;
            next &= ~WallBits[(direction >> 1) ^ 1];
            *pNext = next;
            if ((next & Terrain_Mask) == Terrain_Space) {
                DrawTerrain(nextMapX, nextMapY, next);
            }
            else {
                DrawTerrainBytes(nextMapX, nextMapY, MidChars + (direction << 1));
            }
        }
        draw:
        Draw();
    }
}


void LooseMan()
{
    static const byte[] Chars = {
        0x3b, 0x7b, 0xf6, 0xf4,
        0x3a, 0xf6, 0x7a, 0xf2,
        0xf2, 0xf6, 0x3b, 0x7b,
        0xf9, 0x3a, 0xf1, 0x7a,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&man, Chars + ((i & 3) << 2));
        // UpdateSprites();
        DrawAll();
        Sound_Loose();
        // CallSound();
        ++i;
    } while (i < 8);
    man.status &= ~Movable_Status_Live;
}
