#include "Goal.h"
#include "Sprite.h"
#include "VVram.h"

constexpr byte Width = 4;
constexpr byte Height = 4;

void DrawGoal()
{
    static const byte[] Chars = {
	    0x07, 0x05, 0x05, 0x0d, 0x0b, 0x0a, 0x0a, 0x0e,
	    0x0c, 0x00, 0x00, 0x03, 0x0c, 0x00, 0x00, 0x03,
    };
    byte x;
    x = GoalX - 1 - LeftX;
    if (x < VVramWidth) {
        ptr<byte> pVVram, pChar;
        pVVram = VVramBack + VVramOffset(x, GoalY - Height + 2);
        pChar = Chars;
        repeat (Height) {
            repeat (Width) {
                byte c;
                c = *pChar;
                if (c != 0 && x < VVramWidth) {
                    *pVVram = c;
                }
                ++pVVram;
                ++pChar;
                ++x;
            }
            pVVram += VVramWidth - Width;
            x -= Width;
        }
    }
}
