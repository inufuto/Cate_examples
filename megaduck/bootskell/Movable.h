constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte MapShift = CoordShift + 1;
constexpr byte MapRate = CoordRate * 2;
constexpr byte MapMask = MapRate - 1;

constexpr byte Movable_SeqMask = 0x01;
constexpr byte Movable_DirectionMask = 0x06;
constexpr byte Movable_PatternMask = Movable_DirectionMask | Movable_SeqMask;
constexpr byte Movable_Live = 0x80;
constexpr byte Movable_Pushing = 0x40;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 2;
constexpr byte Direction_Up = 4;
constexpr byte Direction_Down = 6;


struct Movable
{
    byte x, y;
    byte sprite;
    sbyte dx, dy;
    byte status;
    byte clock;
};


extern const sbyte[] DirectionElements;

extern void LocateMovableB(ptr<Movable> pMovable, byte b);
extern bool IsOnGrid(ptr<Movable> pMovable);
extern void SetDirection(ptr<Movable> pMovable, byte direction);
extern byte GetCellOrMovable(ptr<Movable> pMovable, byte x, byte y);
extern byte NextCellOrMovable(ptr<Movable> pMovable, byte direction);
extern bool IsNear(ptr<Movable> p1, ptr<Movable>p2);
extern byte GetCellOrBlock(ptr<Movable> pMovable, byte x, byte y);
