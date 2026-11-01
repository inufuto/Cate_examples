constexpr byte StageWidth = 128;
constexpr byte StageHeight = 192;

constexpr byte MaginX = 0x100 - StageWidth;
constexpr byte MaginY = 0x100 - StageHeight;

struct Position {
	byte x, y;
};

struct BarrierDef {
	byte x, y, length, flags;
};

struct StageDef {
	byte startX, startY;
	byte fortCount;
	ptr<Position> fortPositions;
	byte barrierCount;
	ptr<BarrierDef> barriers;
};

extern const StageDef[] StageDefs;

extern byte BaseX, BaseY;
extern byte CurrentStage;

extern void InitStage();
extern void InitTrying();
extern void UpdateBasePosition();
extern byte AddX(byte x, sbyte dx);
extern byte AddY(byte y, sbyte dy);
extern sbyte SubX(byte x1, byte x2);
extern sbyte SubY(byte y1, byte y2);
extern byte OffsetX(byte x);
extern byte OffsetY(byte y);
