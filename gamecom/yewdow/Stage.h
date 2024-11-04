constexpr byte MapWidth = 12;
constexpr byte MapHeight = 7;
constexpr byte MapWidthPerByte = 8 / 4;
constexpr byte MaxItemCount = 8;

constexpr byte StageWidth = MapWidth * 2;
constexpr byte StageHeight = MapHeight * 2;

constexpr byte Cell_Space = 0x0;
constexpr byte Cell_Wall = 0x1;
constexpr byte Cell_Rock = 0x2;
constexpr byte Cell_Arrow = 0x4;
constexpr byte Cell_Item = 0x8;
constexpr byte Cell_NullArrow = 0xc;

struct Stage {
    byte start;
    byte[MaxItemCount] items;
    byte carCount;
    ptr<byte> pCars;
    byte monsterCount;
    ptr<byte> pMonsters;
    byte[MapWidth / MapWidthPerByte * MapHeight] bytes;
};
extern const Stage[] Stages;
extern ptr<Stage> pStage;
extern byte[] CellMap;

extern void InitStage();
extern void InitTrying();
extern bool CanMoveTo(byte x, byte y);
extern void EraseCell(byte x, byte y);

extern byte GetCell(byte x, byte y);
extern byte SetCell(byte x, byte y, byte cell);