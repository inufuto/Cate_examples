constexpr byte Bullet_Direction_Mask = 0x06;
constexpr byte Bullet_HV_Mask = 0x04;
constexpr byte Bullet_Pattern_Mask = 0x01;
constexpr byte Bullet_Live_Mask = 0x10;
constexpr byte Bullet_Side_Mask = 0x20;
constexpr byte Bullet_Side_My = 0;

struct Bullet {
    byte x, y;
    sbyte dx, dy;
    byte width, height;
    byte sprite;
    byte status;
};

extern void IntBullets();
extern void StartMyBullet(byte x, byte y, byte direction);
extern void StartEnemyBullet(byte x, byte y, byte direction);
extern void MoveMyBullets();
extern void MoveEnemyBullets();
