; ; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
; cseg
; CopyMemory_: public CopyMemory_
;     push xhl | push xde | push xbc
;         ld hl,bc | ld qhl,0
;         ld bc,de
;         ld de,wa | ld qde,0
;         ldir
;     pop xbc | pop xde | pop xhl
; ret


; void FillMemory(ptr<byte> pDestination, word length, byte b);
cseg
FillMemory_: public FillMemory_
    push xwa | push bc
        do
            ld (xwa+),e
        dwnz bc
    pop bc | pop xwa
ret
