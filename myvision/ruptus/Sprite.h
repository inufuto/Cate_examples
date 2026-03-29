constexpr byte Sprite_Fighter = 0;
constexpr byte Sprite_MapPoint = Sprite_Fighter + 1;
constexpr byte Sprite_Item = Sprite_MapPoint + 1;
constexpr byte Sprite_Enemy = Sprite_Item + 1;
constexpr byte Sprite_Barrier = Sprite_Enemy + 3;
constexpr byte Sprite_FighterBullet = Sprite_Barrier + 6;
constexpr byte Sprite_EnemyBullet = Sprite_FighterBullet + 4;
constexpr byte Sprite_Bang = Sprite_EnemyBullet + 4;
constexpr byte Sprite_End = Sprite_Bang + 12;

struct Sprite {
    byte y, x, name, color;
};
extern Sprite[] Sprites;

extern void ShowSprite(byte index, byte x, byte y, sbyte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
extern void RotateSprites();
