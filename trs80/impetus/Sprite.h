constexpr byte Sprite_GroundEnemy = 0;
constexpr byte Sprite_Fighter = 4;
constexpr byte Sprite_SkyEnemy = 5;
constexpr byte Sprite_FighterBullet = 8;
constexpr byte Sprite_EnemyBullet = 10;
constexpr byte Sprite_Item = 14;
constexpr byte Sprite_Bang = 15;
constexpr byte SpriteCount = 19;


struct Sprite {
    byte x, y;
    byte code;
};

extern void InitSprites();
extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, byte code);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
