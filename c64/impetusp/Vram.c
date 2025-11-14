#include "Vram.h"
#include "VVram.h"
#include "Stage.h"
#include "Fort.h"

bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        UpdateGroundChars(true);
        GroundToVVram();
        DrawForts();
        VVramToVram();
    }
}
