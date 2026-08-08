#include "Goal.h"
#include "Sprite.h"
#include "VVram.h"

constexpr byte Width = 4;
constexpr byte Height = 4;

void DrawGoal()
{
    static const byte[] Chars = {
        0xe0, 0xa0, 0xa0, 0xb0, 0xd0, 0x50, 0x50, 0x70,
        0x30, 0x00, 0x00, 0xc0, 0x30, 0x00, 0x00, 0xc0,
    };
    byte x;
    x = GoalX - 1 - LeftX;
    if (x < VVramWidth) {
        ptr<byte> pVVram, pChar;
        pVVram = VVramPtr(x, GoalY - Height + 2);
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
