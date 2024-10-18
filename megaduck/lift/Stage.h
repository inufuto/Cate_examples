constexpr byte Cell_Index = 0x07;
constexpr byte Cell_Type = 0x38;
constexpr byte Cell_Type_Floor = 0x08;
constexpr byte Cell_Type_LiftBit = 0x10;
constexpr byte Cell_Type_LiftBottom = Cell_Type_LiftBit | Cell_Type_Floor;
constexpr byte Cell_Type_Item = 0x28;
constexpr byte Cell_LeftLift = 0x40;
constexpr byte Cell_RightLift = 0x80;


constexpr byte StageTop = 2 + 2;
constexpr byte FloorCount = 3;
constexpr byte ColumnCount = 12;
constexpr byte FloorHeight = 4;
constexpr byte ColumnWidth = 2;
constexpr byte StageBottom = StageTop + FloorHeight * FloorHeight;

struct Stage {
    byte[8] floorBits;
    byte manPosition;
    // byte cartPosition;
    byte monsterCount;
    ptr<byte> pMonsters;
    byte itemCount;
    ptr<byte> pItems;
    byte liftCount;
    ptr<byte> pLifts;
};

extern Stage[] Stages;
extern ptr<Stage> pStage;
extern byte[] CellMap;

extern void InitStage();
extern void InitTrying();
extern byte ToX(byte b);
extern byte ToY(byte b);
extern ptr<byte> CellMapPtr(byte x, byte y);
extern bool CanMoveToXY(byte x, byte y);
