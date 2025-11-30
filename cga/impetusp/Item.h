#include "Movable.h"

struct Item : Movable {
};

extern Item Item;

extern void InitItem();
extern void StartItem(byte x, byte y);
extern void MoveItem();
