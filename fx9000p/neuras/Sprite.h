struct Sprite {
    byte x, y;
    byte pattern;
    byte oldX, oldY;
    byte oldPattern;
};

constexpr byte SpriteCount = 6;

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, sbyte pattern);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
