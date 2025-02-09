#include "VVram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVramBack;
byte[VVramWidth * VVramHeight] VVramFront;
bool VVramChanged;
byte[3] RowFlags;
