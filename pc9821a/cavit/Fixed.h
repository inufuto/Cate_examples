constexpr byte Fixed_Status_None = 0x00;
constexpr byte Fixed_Status_Exist = 0x01;

struct Fixed
{
    byte x, y;
    byte sprite;
    byte status;
};

extern byte FixedX(byte b);
extern byte FixedY(byte b);
extern ptr<byte> InitFixeds(ptr<Fixed> pObj, byte sprite, byte maxCount, ptr<byte> pStage);
extern void HitBox();
