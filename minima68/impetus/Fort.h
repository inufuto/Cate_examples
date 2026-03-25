extern byte FortY;
extern byte FortLife;
extern byte FortCharOffset;
extern bool FortChanged;

extern void InitFort();
extern void StartFort();
extern void DrawFort();
extern void EraseFort();
extern void MoveFort();
extern bool HitFort(byte x, byte y);

extern void UpdateFortChars();
