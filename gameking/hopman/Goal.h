#include "Stage.h"
#include "Vram.h"

constexpr byte GoalX = StageWidth - 4 + 1;
constexpr byte GoalY = (StageTop + FloorHeight * (FloorCount - 1) + 1) * CoordRate;

extern void InitGoal();
extern void ShowGoal();