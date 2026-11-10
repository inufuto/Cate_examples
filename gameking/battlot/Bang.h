struct Bang {
    byte x, y;
    byte status;
};

extern Bang[] Bangs;

extern void InitBangs();
extern void StartBang(byte x, byte y, bool large);
extern void UpdateBangs();
