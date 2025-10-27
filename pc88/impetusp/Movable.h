constexpr byte CoordShift = 0;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

struct Movable
{
    byte x, y;
    byte sprite;
};
