; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
cseg
CopyMemory_: public CopyMemory_
    push psw | push h | push d | push b
        do
            ldax d | inx d
            mov m,a | inx h
            dcx b
            mov a,c
            ora b
        while nz | wend
    pop b | pop d | pop h | pop psw
ret


; ; void FillMemory(ptr<byte> pDestination, word length, byte b);
; cseg
; FillMemory_: public FillMemory_
;     push psw | push h | push d
;         do
;             mov m,c | inx h
;             dcx d
;             mov a,e
;             ora d
;         while nz | wend
;     pop d | pop h | pop psw
; ret
