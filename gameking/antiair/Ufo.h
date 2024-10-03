#include "Stage.h"

struct UfoRow {
    byte memberCount;
    byte[ColumnCount] columns;
};

extern UfoRow[] UfoRows;
extern byte UfoCount;
extern byte UfoRowCenterX;
extern byte UfoRowCenterXd;

extern void InitUfos();
extern void ResetUfos();
extern void DrawUfos();
extern void MoveUfos();
extern bool HitUfo(byte bulletX, byte bulletY);