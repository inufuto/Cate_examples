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


; ; void FillMemory(ptr<byte> pDestination, word length, byte b);
; cseg
; FillMemory_: public FillMemory_
;     phsw $13
;         pre iz,$10
;         do
;             sti $2,(iz+$sx)
;             sbw $12,$sy
;         while nz | wend
;     ppsw $12
; rtn
