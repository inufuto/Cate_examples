constexpr byte ColumnCount = 8;
constexpr byte RowCount = 6;

constexpr byte Panel_Left = 0x01;
constexpr byte Panel_Right = 0x02;
constexpr byte Panel_Top = 0x04;
constexpr byte Panel_Bottom = 0x08;
constexpr byte Panel_Exist = 0x10;
// constexpr byte Panel_Movable = 0x20;
constexpr byte Panel_Star = 0x40;

struct Stage {
    byte[ColumnCount * RowCount] bytes;
    byte start;
    byte monsterCount;
    ptr<byte> pMonsters;
};

extern ptr<Stage> pStage;
extern byte[] PanelMap;
extern byte StarCount;

extern ptr<byte> MapPtr(byte column, byte row);

extern byte ToCoord(byte a);
extern void InitStage();
extern void InitTrying();
extern void StartMovingPanel();
extern void MovePanel();