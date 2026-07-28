#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

extern void _deb();

static ptr<byte> PrintS(ptr<byte> pPattern, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pPattern = PrintC(pPattern, c);
        ++p;
    }
    return pPattern;
}

void PrintStatus() 
{
    TileSprites(Sprite_Score, SpriteWidth * 0, 0, Pattern_Score, 3, 15);
    PrintS(PatternRam + SpritePatternSize * Pattern_Score, " SCORE");
    TileSprites(Sprite_Stage, SpriteWidth * 3, 0, Pattern_Stage, 3, 15);
    PrintS(PatternRam + SpritePatternSize * Pattern_Stage, " STAGE");
    PrintByteNumber2(PatternRam + SpritePatternSize * (Pattern_Stage + 2) + SpritePatternSize / 2, CurrentStage + 1);
    ShowSpriteXY(Sprite_Food, SpriteWidth * 7, 0, Pattern_Food, 11);
    ShowSpriteXY(Sprite_FoodCount, SpriteWidth * 8, 0, Pattern_FoodCount, 15);
    {
        byte x = SpriteWidth * 9;
        byte sprite = Sprite_Remain;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                ShowSpriteXY(sprite, x, 0, Pattern_Man, 15);
                x += SpriteWidth;
                ++sprite;
                ShowSpriteXY(sprite, x, 0, Pattern_Remain, 15);
                ++sprite;
                PrintC(PatternRam + SpritePatternSize * Pattern_Remain + SpritePatternSize / 2, i + '0');
            }
            else {
                do {
                    ShowSpriteXY(sprite, x, 0, Pattern_Man, 15);
                    x += SpriteWidth;
                    ++sprite;
                    --i;
                } while (i > 0);
            }
        }
        while (sprite < Sprite_Remain + 2) {
            HideSprite(sprite);
            ++sprite;
        }
    }
    PrintScore();
    PrintFoodCount();
}

void PrintScore()
{
    ptr<byte> pPattern = PrintNumber5(PatternRam + SpritePatternSize * Pattern_Score + SpritePatternSize / 2, Score);
    PrintC(pPattern, '0');
}

void PrintFoodCount()
{
    PrintC(PatternRam + SpritePatternSize * Pattern_FoodCount + SpritePatternSize / 2, FoodCount + '0');
}

void PrintGameOver()
{
    TileSprites(Sprite_Message1, CharWidth * (24 - 9) / 2, CharHeight * 12, Pattern_Message1, 5, 15);
    PrintS(PatternRam + SpritePatternSize * Pattern_Message1, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        constexpr byte LogoLength = 5;
        constexpr byte LogoLeft = (24 - 4 * LogoLength) / 2 * CharWidth;
        constexpr byte LogoTop = CharHeight * 6;
        byte sprite = Sprite_Logo;
        byte pattern = Pattern_Logo;
        byte y = LogoTop;
        repeat (2) {
            byte x = LogoLeft;
            repeat (LogoLength * 2) {
                ShowSpriteXY(sprite, x, y, pattern, 6);
                x += SpriteWidth;
                ++sprite;
                ++pattern;
            }
            y += SpriteHeight;
        }
        TileSprites(Sprite_Mini, LogoLeft + (LogoLength * 4 - 4) * CharWidth, LogoTop + SpriteHeight * 2, Pattern_Mini, 2, 15);
        PrintS(PatternRam + SpritePatternSize * Pattern_Mini, "MINI");
    }
    TileSprites(Sprite_Message1, CharWidth * 3, CharHeight * 20, Pattern_Message1, 10, 15);
    PrintS(PatternRam + SpritePatternSize * Pattern_Message1, "PUSH TRIGGER BUTTON");
    TileSprites(Sprite_Message2, CharWidth * 12, CharHeight * 23, Pattern_Message2, 6, 15);
    PrintS(PatternRam + SpritePatternSize * Pattern_Message2, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram = Vram + VramWidth;
    //     repeat (12) {
    //         *pVram = 0xff;
    //         pVram += VramWidth + 1;
    //     }
    // }
    // {
    //     byte a = 0;
    //     repeat (16) {
    //         SetWall(a, a);
    //         ++a;
    //     }
    // }
}