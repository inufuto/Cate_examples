constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Block = 1;
constexpr byte Sprite_Fire = 2;
constexpr byte Sprite_Monster = 6;
constexpr byte Sprite_Item = 14;
constexpr byte SpriteCount = 15;

struct Sprite {
    byte x, y, pattern;
    byte oldX, oldY, oldPattern;
};
extern Sprite[] Sprites;

extern void ShowSprite(ptr<Movable> pMovable, byte pattern);
extern void HideSprite(byte sprite);
extern void HideAllSprites();
extern void EraseSprites();
extern void DrawSprites();
