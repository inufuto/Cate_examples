constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte MapShift = CoordShift + 1;
constexpr byte MapRate = CoordRate * 2;
constexpr byte MapMask = MapRate - 1;

struct Movable
{
    byte x, y;
    byte sprite;
    byte clock;
};


extern const sbyte[] DirectionElements;

extern void LocateMovableB(ptr<Movable> pMovable, byte b);
extern bool IsOnGrid(ptr<Movable> pMovable);
extern byte GetCellOrMovable(ptr<Movable> pMovable, byte x, byte y);
extern byte NextCellOrMovable(ptr<Movable> pMovable, byte direction);
extern bool IsNear(ptr<Movable> p1, ptr<Movable>p2);
extern byte GetCellOrBlock(ptr<Movable> pMovable, byte x, byte y);
