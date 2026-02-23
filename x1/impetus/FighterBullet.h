struct FighterBullet {
    byte x, y;
    byte sprite;
    byte clock;
};

extern void InitFighterBullets();
extern void StartFighterBullet(bool on);
extern void MoveFighterBullets();
