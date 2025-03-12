#include "Vram.h"
#include "Movable.h"

constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Block = 1;
constexpr byte Sprite_Fire = 2;
constexpr byte Sprite_Monster = 6;
constexpr byte Sprite_Item = 14;
constexpr byte Sprite_Score = 15;
constexpr byte Sprite_HighScore = 16;
constexpr byte Sprite_Stage = 17;
constexpr byte Sprite_Time = 18;
constexpr byte Sprite_Remain = 19;
constexpr byte Sprite_End = 21;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte sprite);
extern void DrawSprites();
