constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte MaxPointCount = 4;
constexpr byte MaxBoxCount = 5;
constexpr byte MaxRockCount = 4;
constexpr byte MaxChaserCount = 4;
constexpr byte MaxGhostCount = 2;
constexpr byte MaxManCount = 1;

constexpr byte Sprite_Point = 0;
constexpr byte Sprite_Rock = 4;
constexpr byte Sprite_Chaser = 8;
constexpr byte Sprite_Ghost = 12;
constexpr byte Sprite_Man = 14;
constexpr byte Sprite_Box = 15;
constexpr byte Sprite_End = 20;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, byte pattern);
extern void HideSprite(byte index);
extern void UpdateSprites();
