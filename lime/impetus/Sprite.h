constexpr byte Sprite_GroundEnemy = 0;
constexpr byte Sprite_Fighter = 4;
constexpr byte Sprite_SkyEnemy = 5;
constexpr byte Sprite_FighterBullet = 8;
constexpr byte Sprite_EnemyBullet = 10;
constexpr byte Sprite_Item = 14;
constexpr byte Sprite_Bang = 15;
constexpr byte SpriteCount = 19;

struct Sprite {
    byte x, y, pattern;
    byte oldX, oldY, oldPattern;
};

extern Sprite[] Sprites;
extern void InitSprites();
extern void ShowSprite(byte index, byte x, byte y, byte pattern);
extern void HideSprite(byte sprite);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
