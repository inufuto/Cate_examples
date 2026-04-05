constexpr byte Item_Y_Mask = 0x1f;
constexpr byte Item_Point_Bit = 0x80;

struct Item {
    byte x, y;
};

extern byte ItemCount;
extern Item[] Items;

extern void InitItems();
extern void DrawItems();
extern void EraseItems();
