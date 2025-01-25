; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
cseg
CopyMemory_: public CopyMemory_
    pushw rr0 | pushw rr2 | pushw rr4 | push r6
        do
            mov r6,(rr2)+
            mov (rr0)+,r6
            decw rr4
        while nz|wend
    pop r6 | popw rr4 | popw rr2 | popw rr0
ret


; ; void FillMemory(ptr<byte> pDestination, word length, byte b);
; cseg
; FillMemory_: public FillMemory_
;     pushw rr0 | pushw rr2
;         do
;             mov (rr0)+,r5
;             decw rr2
;         while nz|wend
;     popw rr2 | popw rr0
; ret
