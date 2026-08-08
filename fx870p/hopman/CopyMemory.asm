; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
cseg
CopyMemory_: public CopyMemory_
    phs $0
    phsw $15
        pre ix,$12
        pre iz,$10
        do
            ldi $0,(ix+$sx)
            sti $0,(iz+$sx)
            sbw $14,$sy
        while nz | wend
    ppsw $14
    pps $0
rtn