#include "Fort.h"
#include "Chars.h"
#include "VVram.h"
#include "Main.h"
#include "Stage.h"
#include "Movable.h"
#include "Sound.h"
#include "Bang.h"
#include "Math.h"
#include "EnemyBullet.h"
#include "MyFighter.h"

constexpr byte Count = 6;
constexpr byte FortWidth = 8;
constexpr byte FortHeight = 4;
constexpr byte InterY = FortHeight * 2;
constexpr byte InvalidY = 0xff;
constexpr byte TopY = 0;
constexpr byte RangeX = StageWidth;
constexpr byte Left = 12;   //VramWidth - 20;
constexpr byte MaxLife = 20;
constexpr byte Pts = 80;
constexpr byte FireMask = (CoordRate << 2) - 1;

byte[64 * FortWidth * FortHeight + 4] FortPattern;
Fort[Count] Forts;
byte FortCount;
byte FortDotOffset;
static bool moving;

void InitForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        pFort->y = InvalidY;
        pFort->oldY = InvalidY;
    }
    FortCount = 0;
    moving = false;
}


static void End(ptr<Fort> pFort)
{
    pFort->y = InvalidY;
    --FortCount;
}


void StartForts()
{
    byte i, x, y;
    ptr<Fort> pFort;
    FortCount = 0;
    i = (CurrentStage + 2) >> 1;
    if (i > Count) {
        i = Count;
    }
    pFort = Forts;
    x = RangeX;
    y = 0;
    do {
        byte targetX;
        targetX = x - (RangeX - Left);
        if (targetX >= RangeX - FortWidth) break;
        pFort->x = x;
        pFort->targetX = targetX;
        pFort->y = y;
        pFort->life = MaxLife;
        pFort->clock = 0;
        ++FortCount;
        ++pFort;
        y += FortHeight * 3 / 2;
        if (y + FortHeight > MinGroundY) {
            x += FortWidth * 4 / 3;
            y = 0;
        }
        --i;
    } while (i != 0);
    FortDotOffset = 0;
    moving = true;
}


static void Fire(ptr<Fort> pFort)
{
    if (
        (pFort->clock & FireMask) == 0 &&
        pFort->x < (RangeX - 2) //&&
        //Rnd() < CurrentStage + 4
    ) {
        byte x, y;
        ptr<Bullet> pBullet;
        x = (pFort->x + 2) << CoordShift;
        y = (pFort->y + 2) << CoordShift;
        pBullet = StartEnemyBullet(x, y);
        if (pBullet != nullptr) {
            pBullet->dx = -1;
            pBullet->dy = Sign(y, MyFighter.y);
            if (pBullet->dy != 0) {
                byte lx, ly;
                lx = Abs(x, MyFighter.x);
                ly = Abs(y, MyFighter.y);
                if (lx < ly) {
                    pBullet->numeratorX = ShortVelocity * 4 / 3;
                    pBullet->numeratorY = LongVelocity * 4 / 3;
                }
                else if (lx > ly) {
                    pBullet->numeratorX = LongVelocity * 4 / 3;
                    pBullet->numeratorY = ShortVelocity * 4 / 3;
                }
                else {
                    pBullet->numeratorX = LoVelocity * 4 / 3;
                    pBullet->numeratorY = LoVelocity * 4 / 3;
                }
            }
            else {
                pBullet->numeratorX = HiVelocity * 4 / 3;
                pBullet->numeratorY = HiVelocity * 4 / 3;
            }
        }
    }
}


void MoveForts()
{
    if (moving) {
        FortDotOffset = (FortDotOffset + 1) & CoordMask;
        if (FortDotOffset == 0) {
            ptr<Fort> pFort;
            for (pFort: Forts) {
                if (pFort->y == InvalidY) continue;
                --pFort->x;
                if (pFort->x <= pFort->targetX) {
                    moving = false;
                }
                Fire(pFort);
            }
            if (!moving) return;
        }
    }
    else {
        ptr<Fort> pFort;
        for (pFort: Forts) {
            if (pFort->y == InvalidY) continue;
            Fire(pFort);
            ++pFort->clock;
        }
    }
}


bool HitBulletFort(byte x, byte y)
{
    ptr<Fort> pFort;
    byte xx, yy;
    xx = (x >> CoordShift) - 1;
    yy = ((y + CoordRate / 2) >> CoordShift);
    for (pFort: Forts) {
        if (pFort->y == InvalidY) continue;
        if (
            xx >= pFort->x &&
            xx < pFort->x + (FortWidth - 2) &&
            yy  >= pFort->y &&
            yy < pFort->y + (FortHeight)
        ) {
            if (--pFort->life ==0) {
                // Sound_LargeBang();
                StartLargeBang(
                    (pFort->x + FortWidth / 2) << CoordShift,
                    (pFort->y + FortHeight / 2) << CoordShift
                );
                End(pFort);
                AddScore(Pts);
            }
            else {
                // Sound_SmallBang();
                StartSmallBang(x + CoordRate, y + CoordRate);
            }
            Sound_Hit();
            return true;
        }
    }
    return false;
}


void DrawForts()
{
    static const byte[] Chars = {
		// shift0
		Char_Space, Char_Fort010, Char_Fort020, Char_Fort030, Char_Fort040, Char_Fort050, Char_Fort060, Char_Fort070, 
		Char_Space, Char_Fort090, Char_Fort100, Char_Fort110, Char_Fort120, Char_Fort130, Char_Fort140, Char_Fort150, 
		Char_Space, Char_Space, Char_Fort180, Char_Fort190, Char_Fort200, Char_Fort210, Char_Fort220, Char_Fort230, 
		Char_Space, Char_Fort250, Char_Fort260, Char_Fort270, Char_Fort280, Char_Fort290, Char_Fort300, Char_Space, 
		// shift2
		Char_Fort002, Char_Fort012, Char_Fort022, Char_Fort032, Char_Fort042, Char_Fort052, Char_Fort062, Char_Fort072, 
		Char_Fort082, Char_Fort092, Char_Fort102, Char_Fort112, Char_Fort122, Char_Fort132, Char_Fort142, Char_Fort152, 
		Char_Space, Char_Space, Char_Fort182, Char_Fort192, Char_Fort202, Char_Fort212, Char_Fort222, Char_Fort232, 
		Char_Space, Char_Fort252, Char_Fort262, Char_Fort272, Char_Fort282, Char_Fort292, Char_Fort302, Char_Space, 
		// shift4
		Char_Fort004, Char_Fort014, Char_Fort024, Char_Fort034, Char_Fort044, Char_Fort054, Char_Fort064, Char_Fort074, 
		Char_Fort084, Char_Fort094, Char_Fort104, Char_Fort114, Char_Fort124, Char_Fort134, Char_Fort144, Char_Fort154, 
		Char_Space, Char_Fort174, Char_Fort184, Char_Fort194, Char_Fort204, Char_Fort214, Char_Fort224, Char_Fort234, 
		Char_Space, Char_Fort254, Char_Fort264, Char_Fort274, Char_Fort284, Char_Fort294, Char_Space, Char_Space, 
		// shift6
		Char_Fort006, Char_Fort016, Char_Fort026, Char_Fort036, Char_Fort046, Char_Fort056, Char_Fort066, Char_Fort076, 
		Char_Fort086, Char_Fort096, Char_Fort106, Char_Fort116, Char_Fort126, Char_Fort136, Char_Fort146, Char_Fort156, 
		Char_Space, Char_Fort176, Char_Fort186, Char_Fort196, Char_Fort206, Char_Fort216, Char_Space, Char_Fort236, 
		Char_Space, Char_Fort256, Char_Fort266, Char_Fort276, Char_Fort286, Char_Fort296, Char_Space, Char_Space, 
    };
    ptr<Fort> pFort;
    for (pFort: Forts) {
        byte y;
        y = pFort->y;
        if (y != InvalidY) {
            byte x, width;
            x = pFort->x;
            width = RangeX - x;
            if (x < RangeX && width > 0) {
                if (width > FortWidth) {
                    width = FortWidth;
                }
                ptr<byte> pRow = VVramPtr(x, y);
                ptr<byte> pChars = Chars + (FortDotOffset << 5);
                repeat(FortHeight) {
                    ptr<byte> pVVram = pRow;
                    ptr<byte> p = pChars;
                    byte i;
                    for (i = 0; i < width; ++i) {
                        *pVVram = *p;
                        ++pVVram;
                        ++p;
                    }
                    pRow += VVramWidth;
                    pChars += FortWidth;
                }
            }
        }
        pFort->oldX = pFort->x;
        pFort->oldY = pFort->y;
    }
}
