constexpr byte CoordShift = 2;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

struct Movable
{
    byte x, y;
    byte xd, yd;
    byte sprite;
};

extern bool IsNear(byte a, byte b);
extern bool IsNearXY(ptr<Movable> p1, ptr<Movable> p2);
