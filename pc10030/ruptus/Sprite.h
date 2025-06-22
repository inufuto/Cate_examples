constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_MapPoint = 1;
constexpr byte Sprite_Item = 2;
constexpr byte Sprite_Enemy = 3;
constexpr byte Sprite_Barrier = 6;
constexpr byte Sprite_FighterBullet = 12;
constexpr byte Sprite_EnemyBullet = 16;
constexpr byte Sprite_Bang = 20;
constexpr byte SpriteCount = 28;

struct Sprite {
    byte x, y, pattern;
    byte oldX, oldY, oldPattern;
};
extern Sprite[] Sprites;

extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
