#include "Stage.h"

constexpr byte Card_Status_None = 0x00;
constexpr byte Card_Status_Floor = 0x10;
constexpr byte Card_Status_Held = 0x20;


constexpr byte CardCount = 26;

struct Card {
    byte status;
    byte x, y;
};

extern Card[CardCount] Cards;
extern ptr<Card> pHeldCard;
extern byte RemainCardCount;

extern void InitCards(ptr<CardPosition> pPositions, byte count);
extern void DrawCards();
extern void PickCard();
extern void ThrowCard(byte x, byte y, sbyte dx, sbyte dy);
extern void MoveCard();