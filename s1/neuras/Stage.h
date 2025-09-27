constexpr byte StageWidth = 32;
constexpr byte StageHeight = 22;
constexpr byte CardOffset = 1;

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
