constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Lift = 3;
constexpr byte Sprite_Point = 9;
constexpr byte SpriteCount = 13;

extern void HideAllSprites();
extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte index);
extern void UpdateSprites();
