#include "Stage.h"
#include "Stages.h"
#include "Window.h"
#include "Fighter.h"
#include "Fort.h"
#include "Barrier.h"
#include "Enemy.h"
#include "FighterBullet.h"
#include "Bang.h"
#include "Sprite.h"
#include "EnemyBullet.h"
#include "Item.h"

byte CurrentStage;
byte BaseX, BaseY;

static ptr<StageDef> pStage;

void InitStage()
{
    byte i, j;
    i = 0;
    j = 0;
    pStage = StageDefs;
    while (i < CurrentStage) {
        ++pStage;
        ++i;
        ++j;
        if (j >= StageCount) {
            pStage = StageDefs;
            j = 0;
        }
    }
    InitForts(pStage->fortPositions, pStage->fortCount);
    InitBarriers(pStage->barriers, pStage->barrierCount);
}

void InitTrying()
{
    HideAllSprites();
    InitFighter(pStage->startX, pStage->startY);
    InitEnemies();
    InitFighterBullets();
    InitEnemyBullets();
    InitBans();
    InitItem();
    WindowChanged = true;
}

void UpdateBasePosition()
{
    byte x, y;
    x = FighterX - WindowWidth / 2;
    y = FighterY - WindowHeight / 2;
    if (x != BaseX || y != BaseY) {
        BaseX = x; BaseY = y;
        WindowChanged = true; 
    }
}

byte AddX(byte x, sbyte dx) 
{
    x += dx;
    if (x >= StageWidth) {
        if (dx < 0) {
            x += StageWidth;
        }
        else {
            x -= StageWidth;
        }
    }
    return x;
}


byte AddY(byte y, sbyte dy)
{
    y += dy;
    if (y >= StageHeight) {
        if (dy < 0) {
            y += StageHeight;
        }
        else {
            y -= StageHeight;
        }
    }
    return y;
}


sbyte SubX(byte x1, byte x2) 
{
    if (x1 > x2) {
        byte d;
        d = x1 - x2;
        if (d < StageWidth / 2) {
            return d;
        }
        else {
            return d - StageWidth;
        }
    }
    else {
        byte d;
        d = x2 - x1;
        if (d < StageWidth / 2) {
            return -d;
        }
        else {
            return StageWidth - d;
        }
    }
}


sbyte SubY(byte y1, byte y2) 
{
    if (y1 > y2) {
        byte d;
        d = y1 - y2;
        if (d < StageHeight / 2) {
            return d;
        }
        else {
            return d - StageHeight;
        }
    }
    else {
        byte d;
        d = y2 - y1;
        if (d < StageHeight / 2) {
            return -d;
        }
        else {
            return StageHeight - d;
        }
    }
}


byte OffsetX(byte x) 
{
    if (BaseX >= StageWidth) {
        if (x >= StageWidth / 2) {
            x -= StageWidth;
        }
    }
    else if (BaseX + WindowWidth >= StageWidth) {
        if (x < StageWidth / 2) {
            x += StageWidth;
        }
    }
    return x - BaseX;
}


byte OffsetY(byte y) 
{
    if (BaseY >= StageHeight) {
        if (y >= StageHeight / 2) {
            y -= StageHeight;
        }
    }
    else if (BaseY + WindowHeight >= StageHeight) {
        if (y < StageHeight / 2) {
            y += StageHeight;        
        }
    }
    return y - BaseY;
}
