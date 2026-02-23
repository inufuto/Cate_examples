#include "Box.h"
#include "Stage.h"
#include "Stages.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Point.h"
#include "Man.h"
#include "Sound.h"

Movable[MaxBoxCount] Boxes;
byte BoxCount;

ptr<byte> InitBoxes(ptr<byte> pStage)
{
    return InitMovables(Boxes, MaxBoxCount, Sprite_Box, pStage);
}


void DrawBoxes()
{
    ptr<Movable> pBox;
    BoxCount = 0;
    for (pBox: Boxes) {
        if (pBox->status == 0) continue;
        ShowSprite(pBox, GChar_Box);
        *TerrainMapPtr(pBox->x >> 1, pBox->y >> 1) |= Terrain_Soil | Wall_All;
        ++BoxCount;
    }
}


void HitBox()
{
    byte x, y;
    ptr<Movable> pBox;
    // x = man.x >> CoordShift;
    // y = man.y >> CoordShift;
    for (pBox: Boxes) {
        if (pBox->status == 0) continue;
        if (pBox->x == man.x && pBox->y == man.y) {
            HideSprite(pBox->sprite);
            pBox->status = 0;
            Sound_Get();
            StartPoint(man.x, man.y, 0);
            --BoxCount;
            return;
        }
    }
}
