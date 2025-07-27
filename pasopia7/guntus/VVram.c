#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "EnemyRow.h"
#include "Star.h"
#include "Sound.h"

bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        ClearVVram();
        DrawStars();
        DrawEnemyRows();
        VVramBackToFront();
        DrawSprites();
        VVramToVramAll();
        BackgroundChanged = false;
        StarChanged = false;
        EnemyRowChanged = false;
    }
    else {
        if (EnemyRowChanged) {
            EnemyRowChanged = false;
            StarChanged = false;
            ClearVVram();
            DrawStars();
            DrawEnemyRows();
            VVramBackToFront();
            SetSpriteRowFlags();
        }
        else if (StarChanged) {
            StarChanged = false;
            EraseStars();
            DrawStars();
            DrawEnemyRows();
            VVramBackToFront();
            SetSpriteRowFlags();
        }
        else {
            EraseSprites();
        }
        DrawSprites();
        VVramToVramChanged();
    }
    // CallSound();
}


ptr<byte> VPut2C(ptr<byte> pVVram, byte c)
{
    repeat (2) {
        repeat (4) {
            *pVVram = c; ++pVVram;
            ++c;
            *pVVram = 0; ++pVVram;
        }
        pVVram += VVramWidth - 4 * 2;
    }
    return pVVram + 4 * 2 - VVramWidth * 2;
}