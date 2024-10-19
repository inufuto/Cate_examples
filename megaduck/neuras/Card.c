#include "Card.h"
#include "Solver.h"
#include "Monster.h"
#include "Main.h"

#include "Chars.h"
#include "Vram.h"
#include "Sprite.h"
#include "Status.h"
#include "Sound.h"

extern void WaitTimer(byte t);

constexpr byte Sprite = 5;

Card[CardCount] Cards;
ptr<Card> pHeldCard;
ptr<Card> pThrownCard;
byte RemainCardCount;

byte CardX, CardY;
sbyte CardDx, CardDy;

static byte FromPosition(byte a)
{
    return a + a + a + 1;
}

static void PutCard(byte x, byte y, byte c) 
{
    Put2C(VramPtr(x - 1, y + CardOffset - 1), Char_Card + (c << 2));
}

static void EraseCard(byte x, byte y) 
{
    Erase2(VramPtr(x - 1, y + CardOffset - 1));
}


void InitCards(ptr<CardPosition> pPosition, byte count) 
{
    ptr<Card> pCard;
    byte i;

    RemainCardCount = count;
    pCard = Cards;
    i = 0;
    while (count != 0 && i < CardCount) {
        pCard->status = Card_Status_Floor | pPosition->number;
        pCard->x = FromPosition(pPosition->position >> 4);
        pCard->y = FromPosition(pPosition->position & 0x0f);
        PutCard(pCard->x, pCard->y, 0);
        ++pCard;
        ++pPosition;
        --count;
        ++i;
    }
    while (i < CardCount) {
        pCard->status = Card_Status_None;
        ++pCard;
        ++i;
    }

    pHeldCard = nullptr;
    pThrownCard = nullptr;
}

void PickCard() 
{
    byte x, y;
    ptr<Card> pCard;

    if (pHeldCard == nullptr) {
        x = (SolverX + 4) >> 3;
        y = (SolverY + 4) >> 3;

        for (pCard: Cards) {
            if (
                (pCard->status & 0xf0) == Card_Status_Floor &&
                pCard->x == x && pCard->y == y
            ) {
                pHeldCard = pCard;
                pCard->status = (pCard->status & 0x0f) | Card_Status_Held;
                Sound_Get();
                EraseCard(pCard->x, pCard->y);
                // BackgndToVVram();
                PrintHeldCard();
                return;
            }
        }
    }
}

static bool TestToMove(byte x, byte y) 
{
    if (TestMap2(x, y)) {
        byte gridX, gridY;
        ptr<Card> pCard;
        
        gridX = x >> 3;
        gridY = y >> 3;

        for (pCard: Cards) {
            if ((pCard->status & 0xf0) == Card_Status_Floor) {
                byte xDiff, yDiff;
                xDiff = gridX - pCard->x;
                yDiff = gridY - pCard->y;
                if (xDiff + 1 < 3 && yDiff + 1 < 3) {
                    return false;
                }
            }
        }
        return true;
    }
    return false;
}

void ThrowCard(byte x, byte y, sbyte dx, sbyte dy) 
{
    x = (x + 3) & 0xf8;
    y = (y + 3) & 0xf8;
    if (pHeldCard != nullptr && pThrownCard == nullptr && TestToMove(x, y)) {
        ptr<Card> pCard;
        CardX = x;
        CardY = y;
        CardDx = dx << 3;
        CardDy = dy << 3;
        pThrownCard = pHeldCard;
        pHeldCard = nullptr;
        Sound_Get();
        ShowSprite(Sprite, CardX - 8, CardY - 8, Pattern_Card);
        UpdateSprites();
        PrintHeldCard();
    }
}

void TestMatching(ptr<Card> p) 
{
    ptr<Card> pCard;
      
    for (pCard: Cards) {
        if (pCard == p) continue;
        if ((pCard->status & 0xf0) != Card_Status_Floor) continue;

        if (
            (p->x == pCard->x && p->y - pCard->y + 2 < 5) ||
            (p->y == pCard->y && p->x - pCard->x + 2 < 5)
        ) {
            byte number, otherNumber;
            
            number =  p->status & 0xf;
            PutCard(p->x, p->y, number);
            otherNumber = pCard->status & 0xf;
            PutCard(pCard->x, pCard->y, otherNumber);
            // BackgndToVVram();
            // EraseSprites();
            // DrawSprites();
            // VVramToVram();
            if (number == otherNumber) {
                Sound_Hit();
                WaitTimer(10);
                p->status = Card_Status_None;
                EraseCard(p->x, p->y);
                pCard->status = Card_Status_None;
                EraseCard(pCard->x, pCard->y);
                // BackgndToVVram();
                RemainCardCount -= 2;
                AddScore(10);   // 100pts
                return;
            }
            else {
                Sound_Miss();
                WaitTimer(10);
                PutCard(p->x, p->y, 0);
                PutCard(pCard->x, pCard->y, 0);
                // BackgndToVVram();
            }
        }
    }
}


void MoveCard()
{
    if (pThrownCard != nullptr) {
        byte newX, newY;
        newX = CardX + CardDx;
        newY = CardY + CardDy;
        if (TestToMove(newX, newY) && !Monster_TestHit(newX, newY)) {
            byte x;
            CardX = newX;
            CardY = newY;
            x = newX - 8;
            ShowSprite(Sprite, x, newY - 8, Pattern_Card);
            x >>= 3;
            newX = x + CardDx + CardDx;
            if (newX < StageWidth) {
                x = newX;
            }
            SetScrollTarget(x << 3);
            UpdateScroll();
        }
        else {
            ptr<Card> pCard;
            pCard = pThrownCard;
            pThrownCard = nullptr;
            pCard->status = (pCard->status & 0x0f) | Card_Status_Floor;
            pCard->x = (CardX + 4) >> 3;
            pCard->y = (CardY + 4) >> 3;
            PutCard(pCard->x, pCard->y, 0);
            // BackgndToVVram();
            HideSprite(Sprite);
            UpdateSprites();

            TestMatching(pCard);
            SetScrollTarget(SolverX - 8);
        }
    }
}