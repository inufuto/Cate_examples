constexpr byte CoordShift = 0;
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

extern bool IsOnGrid(ptr<Movable> pMovable);
extern bool IsNear(ptr<Movable> p1, ptr<Movable>p2);
