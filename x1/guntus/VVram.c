#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "EnemyRow.h"
#include "Star.h"
#include "Sound.h"
#include "Init.h"

bool AllChanged;

void DrawAll()
{
    if (AllChanged) {
        AllChanged = false;
        StarChanged = false;
        EnemyRowChanged = false;
        ClearTVVram();
        PollVSync();
        DrawStars();
        PollVSync();
        DrawEnemyRows();
        PollVSync();
        ClearGVVram();
        PollVSync();
        DrawSprites();
        PollVSync();
        GVVramToVramAll();
        PollVSync();
        TVVramToVram();
    }
    else {
        if (EnemyRowChanged) {
            EnemyRowChanged = false;
            StarChanged = false;
            ClearTVVram();
            PollVSync();
            DrawStars();
            PollVSync();
            DrawEnemyRows();
            PollVSync();
            // VVramBackToFront();
            // SetSpriteRowFlags();
        }
        else if (StarChanged) {
            StarChanged = false;
            EraseStars();
            PollVSync();
            DrawStars();
            PollVSync();
            DrawEnemyRows();
            PollVSync();
            // VVramBackToFront();
            // SetSpriteRowFlags();
        }
        EraseSprites();
        PollVSync();
        DrawSprites();
        PollVSync();
        GVVramToVramChanged();
        PollVSync();
        TVVramToVram();
    }
    // CallSound();
}


ptr<byte> VPut2C(ptr<byte> pVVram, byte c)
{
    repeat (2) {
        repeat (4) {
            *pVVram = c; ++pVVram;
            ++c;
            PollVSync();
        }
        pVVram += TVVramWidth - 4;
    }
    return pVVram + 4 - TVVramWidth * 2;
}