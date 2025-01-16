#include "Movable.h"

// struct Fire : Movable {
//     byte time;
// };
constexpr byte Fire_time = 6;
constexpr byte Fire_unitSize = 7;

// extern Fire[] Fires;
extern byte FireTime;

extern void InitFires();
extern void StartFire();
extern void MoveFires();
