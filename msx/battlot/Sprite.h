constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Sprite_MyRobo = 0;
constexpr byte Sprite_EnemyRobo = 1;
constexpr byte Sprite_MyBullet = 5;
constexpr byte Sprite_EnemyBullet = 7;
constexpr byte Sprite_Bang = 13;
constexpr byte SpriteCount = 21;

constexpr byte Pattern_MyRobo = 0;
constexpr byte Pattern_EnemyRobo = 8;
constexpr byte Pattern_Bullet = 16;
constexpr byte Pattern_SmallBang = 18;
constexpr byte Pattern_LargeBang = 19;
constexpr byte Pattern_Count = 23;

struct Sprite {
    byte y, x, name, color;
};
extern Sprite[] Sprites;

extern void InitSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
