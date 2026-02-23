struct FighterBullet {
    byte x, y;
    sbyte dx, dy;
    byte direction;
    byte sprite;
    sbyte numerator, denominator;
};

extern void InitFighterBullets();
extern void StartFighterBullet(bool on);
extern void MoveFighterBullets();