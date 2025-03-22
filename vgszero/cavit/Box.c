#include "Box.h"
#include "Stage.h"
#include "Stages.h"
#include "Chars.h"
#include "Sprite.h"
#include "Point.h"
#include "Man.h"
#include "Sound.h"

Fixed[MaxBoxCount] Boxes;
byte BoxCount;

ptr<byte> InitBoxes(ptr<byte> pStage)
{
    return InitFixeds(Boxes, Sprite_Box, MaxBoxCount, pStage);
}


void DrawBoxes()
{
    ptr<Fixed> pBox;
    BoxCount = 0;
    for (pBox: Boxes) {
        if (pBox->status == 0) continue;
        ShowSprite(pBox->sprite, pBox->x << 3, pBox->y << 3, Pattern_Box);
        *TerrainMapPtr(pBox->x >> 1, pBox->y >> 1) |= Terrain_Soil | Wall_All;
        ++BoxCount;
    }
}


void HitBox()
{
    byte x, y;
    ptr<Fixed> pBox;
    x = man.x >> CoordShift;
    y = man.y >> CoordShift;
    for (pBox: Boxes) {
        if (pBox->status == 0) continue;
        if (pBox->x == x && pBox->y == y) {
            pBox->status = 0;
            HideSprite(pBox->sprite);
            Sound_Get();
            StartPoint(man.x, man.y, 0);
            --BoxCount;
            return;
        }
    }
}
