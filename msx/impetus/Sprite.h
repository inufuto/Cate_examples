constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;


constexpr byte Pattern_Fighter = 0;
constexpr byte Pattern_SkyEnemy = 4;
constexpr byte Pattern_GroundEnemy = 44;
constexpr byte Pattern_FighterBullet = 52;
constexpr byte Pattern_EnemyBullet = 56;
constexpr byte Pattern_BarrierHead = 60;
constexpr byte Pattern_Bang = 64;
constexpr byte Pattern_Item = 84;
constexpr byte PatternCount = 88;


constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_SkyEnemy = 1;
constexpr byte Sprite_GroundEnemy = 4;
constexpr byte Sprite_BarrierHead = 8;
constexpr byte Sprite_FighterBullet = 12;
constexpr byte Sprite_EnemyBullet = 14;
constexpr byte Sprite_Item = 18;
constexpr byte Sprite_Bang = 19;
constexpr byte SpriteCount = 23;


struct Sprite {
    byte y, x, pattern, color;
};
extern Sprite[] Sprites;

extern void InitSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
extern void RotateSprites();
