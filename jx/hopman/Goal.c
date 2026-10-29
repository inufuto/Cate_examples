#include "Goal.h"
#include "VVram.h"
#include "Chars.h"

static const byte[] GoalChars0 = {
	Char_Goal + 0, Char_Goal + 1, Char_Goal + 2, Char_Goal + 3, Char_Space, 
	Char_Goal + 4, Char_Goal + 5, Char_Goal + 5, Char_Goal + 6, Char_Space, 
	Char_Goal + 7, Char_Space, Char_Space, Char_Goal + 8, Char_Space, 
	Char_Goal + 7, Char_Space, Char_Space, Char_Goal + 8, Char_Space, 
};
static const byte[] GoalChars1 = {
	Char_Goal + 9, Char_Goal + 10, Char_Goal + 11, Char_Goal + 12, Char_Goal + 13, 
	Char_Goal + 14, Char_Goal + 15, Char_Goal + 5, Char_Goal + 16, Char_Goal + 17, 
	Char_Space, Char_Goal + 18, Char_Space, Char_Goal + 19, Char_Space, 
	Char_Space, Char_Goal + 18, Char_Space, Char_Goal + 19, Char_Space, 
};

void DrawGoal()
{
    byte x = (GoalX - 1) - LeftX;
    ptr<byte> pChars;
    if (DotOffset == 0) {
        pChars = GoalChars0;
    } else {
        pChars = GoalChars1;
        --x;
    }
    ptr<byte> pVVram = VVramPtr(x, GoalY / CoordRate);
    repeat (4) {
        repeat (5) {
            byte c = *pChars;
            ++pChars;
            if (c != Char_Space && x < VVramWidth) {
                *pVVram = c;
            }
            ++pVVram;
            ++x;
        }
        pVVram += VVramWidth - 5;
        x -= 5;
    }
}