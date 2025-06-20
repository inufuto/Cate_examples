constexpr byte Sprite_Man = 0;
constexpr byte Sprite_Monster = 1;
constexpr byte Sprite_Point = 5;
constexpr byte Sprite_Increaser = 13;
constexpr byte SpriteCount = 14;

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
