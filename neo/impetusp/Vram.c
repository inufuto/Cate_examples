#include "Vram.h"
#include "VVram.h"
#include "Stage.h"
#include "Fort.h"

bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        GroundToVVram();
        DrawForts();
        VVramToVram();
    }
}
