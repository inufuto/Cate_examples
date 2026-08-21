#include "Movable.h"

struct Debri : Movable {
};

extern Debri[] Debris;

extern void InitDebris();
extern void StartDebri(byte x, byte y);
extern void FallDebris();
extern void ScanDebris();