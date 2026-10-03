struct Bang {
    byte x, y;
    byte status;
};

extern Bang[] Bangs;

extern void InitBans();
extern void StartBang(byte x, byte y, bool large);
extern void UpdateBangs();
