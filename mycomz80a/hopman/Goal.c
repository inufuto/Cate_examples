#include "Goal.h"
#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"

extern void PollVsync();

constexpr byte Width = 4;
constexpr byte Height = 4;

void DrawGoal()
{
    byte x;
    x = GoalX - 1 - LeftX;
    if (x < VVramWidth) {
        ptr<byte> pVVram;
        byte c;
        pVVram = VVramPtr(x, GoalY - 2);
        c = Char_Goal;
        repeat (Height) {
            repeat (Width) {
                if (x < VVramWidth) {
                    *pVVram = c;
                }
                ++pVVram;
                ++c;
                ++x;
            }
            pVVram += VVramWidth - Width;
            x -= Width;
        }
    }
    PollVsync();
}
