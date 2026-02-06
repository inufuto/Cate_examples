constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Point = 5;
constexpr byte Sprite_Increaser = 13;
constexpr byte SpriteCount = 14;

struct Sprite {
    byte y, x, name, color;
};
extern Sprite[] Sprites;

extern void InitSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
extern void HideSprite(byte index);
extern void HideAllSprites();
extern void UpdateSprites();
