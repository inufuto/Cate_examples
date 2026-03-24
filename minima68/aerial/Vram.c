#include "Vram.h"
#include "Stage.h"
#include "Fort.h"

void DrawAll()
{
    BackgroundToVram();
    DrawForts();
    SwitchPage();
}
