#include "Movable.h"

struct Knife : Movable {
};

extern Knife[] Knives;

extern void InitKnives();
extern void ShowKnives();
extern void PickupKnife();
extern void StartKnife();
extern void MoveKnives();
