constexpr byte MaxFighterCount = 1;
constexpr byte MaxEnemyCount = 8;
constexpr byte MaxFighterBulletCount = 2;
constexpr byte MaxEnemyBulletCount = 4;
constexpr byte MaxItemCount = 1;
constexpr byte MaxBangCount = 4;

constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_Enemy = 1;
constexpr byte Sprite_FighterBullet = 9;
constexpr byte Sprite_EnemyBullet = 11;
constexpr byte Sprite_Item = 15;
constexpr byte Sprite_Bang = 16;
constexpr byte SpriteCount = 20;

extern void InitSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
extern void RotateSprites();
