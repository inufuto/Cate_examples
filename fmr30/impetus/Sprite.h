constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_FighterBullet = 1;
constexpr byte Sprite_SkyEnemy = 3;
constexpr byte Sprite_EnemyBullet = 6;
constexpr byte Sprite_BarrierHead = 10;
constexpr byte Sprite_Item = 14;
constexpr byte Sprite_Bang = 15;
constexpr byte Sprite_GroundEnemy = 19;
constexpr byte SpriteCount = 23;

constexpr byte CoordShift = 1;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

struct Sprite {
    byte x, y, pattern;
    byte oldX, oldY, oldPattern;
};

extern Sprite[] Sprites;

extern void InitSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
