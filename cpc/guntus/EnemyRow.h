struct EnemyRow {
    byte memberCount;
    byte type;
    byte[2] flags;
};

extern EnemyRow[] EnemyRows;
extern byte EnemyRowLeft, EnemyRowWidth;
extern bool EnemyRowChanged;

extern void InitEnemyRows();
extern byte FixedEnemyY(byte target);
extern byte FixedEnemyX(byte target);
extern void AddEnemyRowMember(byte target, byte type);
extern void DrawEnemyRows();
extern void MoveEnemyRows();
extern bool HitEnemyRows(byte bulletX, byte bulletY);
