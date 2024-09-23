constexpr byte Fixed_Status_None = 0x00;
constexpr byte Fixed_Status_Exist = 0x01;

struct Fixed
{
    byte x, y;
    byte status;
};

extern byte FixedX(byte b);
extern byte FixedY(byte b);
extern ptr<byte> InitFixeds(ptr<Fixed> pObjs, byte maxCount, ptr<byte> pStage);

