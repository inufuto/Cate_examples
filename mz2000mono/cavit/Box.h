#include "Fixed.h"

constexpr byte Box_Status_None = 0x00;
constexpr byte Box_Status_Exist = 0x01;

extern Fixed[] Boxes;
extern byte BoxCount;

extern ptr<byte> InitBoxes(ptr<byte> pStage);
extern void DrawBoxes();
extern void HitBox();