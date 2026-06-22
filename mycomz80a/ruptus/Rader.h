extern ptr<byte> VramPointerToRader(byte x, byte y);

extern word RaderAddress(byte x, byte y);
extern void ToggleDot(byte x, byte y);

extern void PlotMarker(word vram, word bytes);

extern void PrintRader();
extern void DrawFortRader(byte x, byte y, bool visible);
extern void DrawFighterOnRader();
