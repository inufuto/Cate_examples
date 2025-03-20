#include "Goal.h"
#include "Sprite.h"
#include "Chars.h"
#include "Vram.h"

constexpr byte Width = 4;
constexpr byte Height = 4;

void DrawGoal()
{
    byte x;
    x = GoalX - 1 - LeftX;
    if (x < WindowWidth) {
        ptr<byte> pVram;
        byte c;
        pVram = VramBack + VramOffset(x, GoalY / CoordRate);
        c = Char_Goal;
        repeat (Height) {
            repeat (Width) {
                if (x < WindowWidth) {
                        pVram = Put(pVram, c);
                }
                else {
                    pVram += VramStep;
                }
                ++c;
                ++x;
            }
            pVram += VramRowSize - Width * VramStep;
            x -= Width;
        }
    }
}
