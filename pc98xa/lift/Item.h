struct Item {
    byte x, y;
    byte type;
};

extern Item[] Items;
extern byte ItemCount;

extern void InitItems();
extern void DrawItems();
extern void BlinkItems();
extern void HitItems();