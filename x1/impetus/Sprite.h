constexpr byte CoordShift = 1;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;


constexpr byte Sprite_GroundEnemy = 0;
constexpr byte Sprite_FighterBullet = 4;
constexpr byte Sprite_Fighter = 6;
constexpr byte Sprite_BarrierHead = 7;
constexpr byte Sprite_SkyEnemy = 11;
constexpr byte Sprite_EnemyBullet = 14;
constexpr byte Sprite_Item = 18;
constexpr byte Sprite_Bang = 19;
constexpr byte SpriteCount = 21;


constexpr word GChar_Space = 0x0;
constexpr word GChar_FighterBullet = 0x1;
constexpr word GChar_EnemyBullet = 0xA;
constexpr word GChar_BarrierHead = 0x13;
constexpr word GChar_Fighter = 0x1C;
constexpr word GChar_SkyEnemy = 0x35;
constexpr word GChar_SkyEnemyA = 0x35;
constexpr word GChar_SkyEnemyB = 0x4E;
constexpr word GChar_SkyEnemyC = 0x116;
constexpr word GChar_GroundEnemy = 0x12F;
constexpr word GChar_GroundEnemyA = 0x12F;
constexpr word GChar_GroundEnemyB = 0x148;
constexpr word GChar_Item = 0x161;
constexpr word GChar_SmallBang = 0x17A;
constexpr word GChar_LargeBang = 0x193;
constexpr word GChar_End = 0x1E4;


struct Sprite {
    byte x, y;
    word code;
    byte oldX, oldY;
    word oldCode;
};

extern void InitSprites();
extern void HideAllSprites();
extern void ShowSprite(byte index, byte x, byte y, word code);
extern void HideSprite(byte index);
extern void EraseSprites();
extern void DrawSprites();

extern void ClearSpriteRam();
extern void WritePattern(word c, ptr<byte> pSource);
extern void WritePatternH(word c, ptr<byte> pSource);
extern void WritePatternV(word c, ptr<byte> pSource, byte width);
extern void WritePatternHV(word c, ptr<byte> pSource, byte width);
