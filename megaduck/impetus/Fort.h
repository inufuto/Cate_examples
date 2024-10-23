constexpr byte FortWidth = 6;
constexpr byte FortHeight = 6;
constexpr byte FortCharCount = FortWidth * (FortHeight + 1);

extern byte FortY;
extern byte FortLife;
extern byte FortCharOffset;
extern bool FortChanged;

extern void InitFort();
extern void StartFort();

extern void SetFortPattern();
extern void DrawFort(word vram);
extern void MoveFort();
extern bool HitFort(byte x, byte y);
