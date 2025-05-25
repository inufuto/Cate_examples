#include "Movable.h"

constexpr byte Man_pDirection = 6;
constexpr byte Man_unitSize = Movable_unitSize + 2;

struct ManDirection : Direction {
    byte key;
};
// struct Man : Movable {
//     ptr<ManDirection> pDirection;
// };

// extern Man Man;

extern void InitMan();
extern void MoveMan();
extern void LooseMan();
