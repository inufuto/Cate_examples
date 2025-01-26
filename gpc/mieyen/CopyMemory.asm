; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, byte length);
cseg
CopyMemory_: public CopyMemory_
    push v | push h | push d | push b
        do
            ldax d+ | stax h+
            dcr c
            sknz | eqa a,a
        repeat
    pop b | pop d | pop h | pop v
ret


; ; void FillMemory(ptr<byte> pDestination, byte length, byte b);
; cseg
; FillMemory_: public FillMemory_
;     push v | push h | push b
;         mov a,e | mov b,a
;         mov a,c
;         do
;             stax h+
;             dcr b
;             sknz | eqa a,a
;         repeat
;     pop b | pop h | pop v
; ret
