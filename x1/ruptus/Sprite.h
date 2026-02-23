constexpr byte Sprite_FighterBullet = 0;
constexpr byte Sprite_Fighter = Sprite_FighterBullet + 4;
constexpr byte Sprite_Item = Sprite_Fighter + 1;
constexpr byte Sprite_Enemy = Sprite_Item + 1;
constexpr byte Sprite_Barrier = Sprite_Enemy + 3;
constexpr byte Sprite_EnemyBullet = Sprite_Barrier + 6;
constexpr byte Sprite_Bang = Sprite_EnemyBullet + 4;
constexpr byte SpriteCount = Sprite_Bang + 8;

struct Sprite {
    byte x, y;
    word code;
    byte oldX, oldY;
    word oldCode;
};

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, word code);
extern void HideSprite(byte index);
extern void EraseSprites();
extern bool DrawSprites();
