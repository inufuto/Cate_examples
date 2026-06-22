#include "Box.h"
#include "Stage.h"
#include "Stages.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Point.h"
#include "Man.h"
#include "Sound.h"

Fixed[MaxBoxCount] Boxes;
byte BoxCount;

ptr<byte> InitBoxes(ptr<byte> pStage)
{
    return InitFixeds(Boxes, MaxBoxCount, pStage);
}


void DrawBoxes()
{
    ptr<Fixed> pBox;
    BoxCount = 0;
    for (pBox: Boxes) {
        if (pBox->status == 0) continue;
        Put4C(pBox->x, pBox->y, Char_Box);
        *TerrainMapPtr(pBox->x >> 1, pBox->y >> 1) |= Terrain_Soil | Wall_All;
        ++BoxCount;
    }
}


void HitBox()
{
    byte x, y;
    ptr<Fixed> pBox;
    // x = man.x >> CoordShift;
    // y = man.y >> CoordShift;
    for (pBox: Boxes) {
        if (pBox->status == 0) continue;
        if (pBox->x == man.x && pBox->y == man.y) {
            pBox->status = 0;
            Sound_Get();
            StartPoint(man.x, man.y, 0);
            --BoxCount;
            return;
        }
    }
}
