#include "Goal.h"
#include "Sprite.h"
#include "Chars.h"

constexpr byte SpriteColor = 3;
static Movable[4] Elements;

void InitGoal()
{
    ptr<Movable> pElement;
    byte sprite;
    sprite = Sprite_Goal;
    for (pElement : Elements) {
        pElement->sprite = sprite;
        pElement->xd = 0;
        ++sprite;
    }
    Elements[0].x = GoalX - 1;
    Elements[1].x = GoalX + 1;
    Elements[2].x = GoalX - 1;
    Elements[3].x = GoalX + 1;
    Elements[0].y = GoalY - CoordRate * 2;
    Elements[1].y = GoalY - CoordRate * 2;
    Elements[2].y = GoalY;
    Elements[3].y = GoalY;
}


void ShowGoal()
{
    ptr<Movable> pElement;
    byte pattern;
    pattern = Pattern_Goal;
    for (pElement : Elements) {
        ShowSprite(pElement, pattern, SpriteColor);
        ++pattern;
    }
}