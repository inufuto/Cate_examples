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
        word vram;
        byte c;
        vram = VramOffset(x, GoalY / CoordRate) + NextPage;
        c = Char_Goal;
        repeat (2) {
            repeat (2) {
                repeat (2) {
                    repeat (2) {
                        if (x < WindowWidth) {
                            vram = WriteVram(vram, c);
                        }
                        else {
                            vram += VramStep;
                        }
                        c += 2;
                        ++x;
                    }
                    c -= 3;
                    vram += VramRowSize - 2 * VramStep;
                    x -= 2;
                }
                c += 2;
                vram += -VramRowSize * 2 + 2 * VramStep;
                x += 2;
            }
            vram += VramRowSize * 2 - 4 * VramStep;
            x -= 4;
        }
    }
}
