constexpr byte StageWidth = 48;
constexpr byte StageHeight = 64;

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

extern void InitStage();
extern void InitTrying();
extern void UpdateBasePosition();
extern byte AddX(byte x, sbyte dx);
extern byte AddY(byte y, sbyte dy);
extern sbyte SubX(byte x1, byte x2);
extern sbyte SubY(byte y1, byte y2);
extern byte OffsetX(byte x);
extern byte OffsetY(byte y);
