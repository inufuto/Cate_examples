constexpr byte HiVelocity = 100;
constexpr byte LoVelocity = HiVelocity * 70 / 100; // sin 45
constexpr byte LongVelocity = HiVelocity * 92 / 100; // cos 22.5
constexpr byte ShortVelocity = HiVelocity * 38 / 100; // sin 22.5

constexpr byte Direction_Up = 0;
constexpr byte Direction_UpRight = 1;
constexpr byte Direction_Right = 2;
constexpr byte Direction_DownRight = 3;
constexpr byte Direction_Down = 4;
constexpr byte Direction_DownLeft = 5;
constexpr byte Direction_Left = 6;
constexpr byte Direction_UpLeft = 7;

struct Direction {
    sbyte dx, dy;
};


extern const Direction[] Directions;


constexpr byte DirectionCount = 4;

struct CourseElement {
    byte[DirectionCount] directions;
};

extern const CourseElement[] CourseElements;

constexpr byte CourseElementCount = 12;
constexpr byte InvalidElement = 0xff;

struct Course {
    byte x, y;
    byte direction;
    byte sallyCount;
    byte[CourseElementCount] elements;
};

extern const Course[] Courses;

extern byte ToDirection(sbyte dx, sbyte dy);
