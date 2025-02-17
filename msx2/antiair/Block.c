#include "Block.h"
#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"
#include "Bang.h"
#include "Sound.h"
#include "Cannon.h"
#include "Status.h"

extern void _deb();

static const byte[] Points = { 10, 4, 6 };

constexpr byte Block_TypeMask = 0x03;

constexpr byte Ground_LeftBlock = 0x01;
constexpr byte Ground_RightBlock = 0x02;
constexpr byte Ground_BlockMask = 0x03;
constexpr byte Ground_LeftBomb = 0x04;
constexpr byte Ground_RightBomb = 0x8;
constexpr byte Ground_BombMask = 0x0c;
constexpr byte Ground_Time = 0x10;
constexpr byte Ground_TimeMask = (CoordRate * 2 - 1) << 4;//0xf0;

FallingBlock[MaxFallingBlockCount] FallingBlocks;
byte[WindowWidth] Ground;


void InitBlocks()
{
    byte sprite;
    ptr<FallingBlock> pBlock;
    sprite = Sprite_FallingBlock;
    for (pBlock: FallingBlocks) {
        pBlock->flags = 0;
        pBlock->_.sprite = sprite;
        HideSprite(sprite);
        ++sprite;
    }
    FillMemory(Ground, WindowWidth, 0);
}

static void Show(ptr<FallingBlock> pBlock)
{
    ShowSprite(
        &pBlock->_, 
        Pattern_Block - 1 + pBlock->flags
    );
}

static void Hide(ptr<FallingBlock> pBlock)
{
    pBlock->flags = 0;
    HideSprite(pBlock->_.sprite);
}

bool StartFallingBlock(byte x, byte y, byte type)
{
    ptr<FallingBlock> pBlock;
    x = (x + CoordRate / 2) & ~CoordMask;
    for (pBlock: FallingBlocks) {
        if (pBlock->flags == 0) {
            pBlock->flags = type;
            pBlock->_.x = x;
            pBlock->_.y = y;
            Show(pBlock);
            return true;
        }
    }
    return false;
}

static void MakeBang(byte bombX)
{
    ptr<byte> pGround;
    StartLargeBang((bombX + 1) << CoordShift, (WindowHeight - 1) * CoordRate);
    Sound_LargeBang();
    HitCannon((bombX - 1) << CoordShift, ((WindowHeight - 2) * CoordRate), 4 * CoordRate);
    pGround = Ground + bombX;
    if (bombX >= 2) {
        if (
            (pGround[-2] & Ground_BlockMask) == Ground_LeftBlock ||
            (pGround[-1] & Ground_BlockMask) == Ground_RightBlock
        ) {
            pGround[-2] &= ~Ground_BlockMask;
        }
    }
    if (bombX >= 1) {
        pGround[-1] &= ~Ground_BlockMask;
    }
    pGround[0] &= ~Ground_BlockMask;
    pGround[1] &= ~Ground_BlockMask;
    if (bombX < WindowWidth - 3) {
        if (
            (pGround[2] & Ground_BlockMask) == Ground_LeftBlock ||
            (pGround[3] & Ground_BlockMask) == Ground_RightBlock
        ) {
            pGround[3] &= ~Ground_BlockMask;
        }
    }
    if (bombX < WindowWidth - 2) {
        pGround[2] &= ~Ground_BlockMask;
    }
    BackgroundChanged = true;
}


void MoveBlocks()
{
    ptr<FallingBlock> pBlock;
    for (pBlock: FallingBlocks) {
        if (pBlock->flags != 0) {
            if ((pBlock->_.y & CoordMask) == 0) {
                byte x, y;
                x = pBlock->_.x >> CoordShift;
                y = pBlock->_.y >> CoordShift;
                if (y >= WindowHeight - 2) {
                    byte type;
                    type = pBlock->flags & Block_TypeMask;
                    switch (type) {
                    case Type_Block:
                        {
                            ptr<byte> pGround;
                            pGround = Ground + x;
                            *pGround = (*pGround & Ground_BombMask) | Ground_LeftBlock;
                            ++pGround;
                            *pGround = (*pGround & Ground_BombMask) | Ground_RightBlock;
                            BackgroundChanged = true;
                        }
                        break;
                    case Type_Bomb:
                        MakeBang(x);
                        break;
                    case Type_TimeBomb:
                        {
                            ptr<byte> pGround;
                            pGround = Ground + x;
                            *pGround = (*pGround & Ground_BlockMask) | Ground_LeftBomb | Ground_TimeMask;
                            ++pGround;
                            *pGround = (*pGround & Ground_BlockMask) | Ground_RightBomb | Ground_TimeMask;
                            BackgroundChanged = true;
                        }
                        break;
                    }
                    Hide(pBlock);
                    goto next;
                }
                else {
                    if (HitCannon(pBlock->_.x, pBlock->_.y, 2 * CoordRate)) {
                        Hide(pBlock);
                        goto next;
                    }
                }
            }
            ++pBlock->_.y;
            Show(pBlock);
        }
        next:;
    }
}

bool HitBlock(byte bulletX, byte bulletY)
{
    ptr<FallingBlock> pBlock;
    for (pBlock: FallingBlocks) {
        if (pBlock->flags != 0) {
            byte x, y;
            x = pBlock->_.x;
            y = pBlock->_.y;
            if (
                bulletX < x + CoordRate * 2 && x < bulletX + CoordRate * 2 &&
                bulletY < y + CoordRate * 2 && y < bulletY + CoordRate * 2
            ) {
                byte type;
                type = pBlock->flags & Block_TypeMask;
                if (type != Type_Block) {
                    AddScore(Points[type - 1]);
                    Hide(pBlock);
                    StartSmallBang(x + CoordRate, y + CoordRate);
                    Sound_SmallBang();
                    // Sound_Hit();
                }
                return true;
            }
        }
    }
    return false;
}


void UpdateBlocks()
{
    ptr<byte> pGround;
    byte x;
    pGround = Ground;
    x = 0;
    while (x < WindowWidth) {
        byte b;
        b = pGround[0];
        if ((b & (Ground_BombMask | Ground_TimeMask)) != 0) {
            b -= Ground_Time;
            if ((b & Ground_TimeMask) == 0) {
                byte bombX;
                bombX = x;
                if ((b & Ground_BombMask) == Ground_RightBomb) {
                    --bombX;
                    if ((pGround[-1] & Ground_BombMask) == Ground_LeftBomb) {
                        pGround[-1] &= Ground_BlockMask;
                    }
                }
                else {
                    if ((pGround[1] & Ground_BombMask) == Ground_RightBomb) {
                        pGround[1] &= Ground_BlockMask;
                    }
                }
                pGround[0] = b & Ground_BlockMask;
                MakeBang(bombX);
                BackgroundChanged = true;
            }
            else {
                pGround[0] = b;
            }
        }
        ++pGround;
        ++x;
    }
}