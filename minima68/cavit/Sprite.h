constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Rock = 4;
constexpr byte Sprite_Ghost = 8;
constexpr byte Sprite_Chaser = 10;
constexpr byte Sprite_Man = 14;
constexpr byte Sprite_Box = 15;
constexpr byte Sprite_End = 20;

constexpr byte MaxBoxCount = 5;

constexpr byte MaxGhostCount = 2;
constexpr byte MaxChaserCount = 4;
constexpr byte MaxPointCount = 4;

extern void ShowSprite(byte index, byte x, byte y, byte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
