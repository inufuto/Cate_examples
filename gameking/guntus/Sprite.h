constexpr byte MaxFighterCount = 1;
constexpr byte MaxEnemyCount = 6;
constexpr byte MaxFighterBulletCount = 2;
constexpr byte MaxEnemyBulletCount = 4 - 1;
constexpr byte MaxItemCount = 1;
constexpr byte MaxBangCount = 4;

constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_Enemy = 1;
constexpr byte Sprite_FighterBullet = 7;
constexpr byte Sprite_EnemyBullet = 9;
constexpr byte Sprite_Item = 13;
constexpr byte Sprite_Bang = 14;
constexpr byte SpriteCount = 18;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
