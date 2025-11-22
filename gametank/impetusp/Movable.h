constexpr byte CoordShift = 2;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

struct Movable
{
    byte x, y;
    byte sprite;
};
