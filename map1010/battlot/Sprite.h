constexpr byte StepMask = 7;

constexpr byte Sprite_MyRobo = 0;
constexpr byte Sprite_EnemyRobo = 1;
constexpr byte Sprite_MyBullet = 5;
constexpr byte Sprite_EnemyBullet = 7;
constexpr byte Sprite_Bang = 13;
constexpr byte SpriteCount = 21;


struct Sprite {
    byte x, y;
    byte code;
    byte oldX, oldY;
    byte oldCode;
};

extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, byte code);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();
