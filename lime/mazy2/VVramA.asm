; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    stb ,x
    tfr x,d
    addd #1
rts