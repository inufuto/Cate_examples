struct Point
{
    Movable _;
    byte clock;
};

extern Point[] Points;

extern void InitPoints();
extern void StartPoint(byte x, byte y, byte rate);
extern void UpdatePoints();
