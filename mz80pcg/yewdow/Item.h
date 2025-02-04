struct Item {
    byte x, y;
};

extern Item[] Items;
extern byte ItemCount;

extern void InitItems();
extern void HitItems(byte x, byte y);
extern void DrawItems();