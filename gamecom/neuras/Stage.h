constexpr byte StageWidth = 3 * 8 + 1;
constexpr byte StageHeight = 3 * 5 + 1;

constexpr byte MapWidth = (StageWidth + 7) / 8;

struct CardPosition {
    byte number;
    byte position;
};

struct Stage {
    byte[18] bytes;
    byte startPosition;
    byte cardCount;
    ptr<CardPosition> cardPositions;
    byte monsterCount;
    ptr<byte> monsterPositions;
};

extern byte CurrentStage;
extern byte[] WallMap;
extern word StageTime;

extern void InitStage();
extern void InitTrying();
extern bool TestMap2(byte x, byte y) ;
