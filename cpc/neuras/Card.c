#include "Card.h"
#include "Solver.h"
#include "Monster.h"
#include "Main.h"

#include "Chars.h"
#include "Vram.h"
#include "Sprite.h"
#include "Status.h"
#include "Sound.h"
#include "Backgnd.h"

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
        VPut2(pCard->x, pCard->y, Pattern_Card);
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
                VErase2(pCard->x, pCard->y);
                BackgndToVVram();
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
        ShowSprite(Sprite, CardX, CardY, Pattern_Card);
        // UpdateSprites();
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
            VPut2(p->x, p->y, Pattern_Card + number);
            otherNumber = pCard->status & 0xf;
            VPut2(pCard->x, pCard->y, Pattern_Card + otherNumber);
            BackgndToVVram();
            EraseSprites();
            DrawSprites();
            VVramToVramAll();
            if (number == otherNumber) {
                Sound_Hit();
                p->status = Card_Status_None;
                VErase2(p->x, p->y);
                pCard->status = Card_Status_None;
                VErase2(pCard->x, pCard->y);
                BackgndToVVram();
                RemainCardCount -= 2;
                AddScore(10);   // 100pts
                return;
            }
            else {
                Sound_Miss();
                VPut2(p->x, p->y, Pattern_Card);
                VPut2(pCard->x, pCard->y, Pattern_Card);
                BackgndToVVram();
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
            CardX = newX;
            CardY = newY;
            ShowSprite(Sprite, newX, newY, Pattern_Card);
        }
        else {
            ptr<Card> pCard;
            pCard = pThrownCard;
            pThrownCard = nullptr;
            pCard->status = (pCard->status & 0x0f) | Card_Status_Floor;
            pCard->x = (CardX + 4) >> 3;
            pCard->y = (CardY + 4) >> 3;
            VPut2(pCard->x, pCard->y, Pattern_Card);
            BackgndToVVram();
            HideSprite(Sprite);
            // UpdateSprites();

            TestMatching(pCard);
        }
    }
}