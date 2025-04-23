struct Sprite {
    byte x, y;
    sbyte pattern;
    byte oldX, oldY;
    sbyte oldPattern;
};

constexpr byte SpriteCount = 6;

extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
extern void InitSprites();
