; ; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
; cseg
; CopyMemory_: public CopyMemory_
;     push af | push hl | push de | push bc
;         do
;             ld a,(de) | inc de
;             ld (hl+),a
;             dec bc
;             ld a,c | or a,b
;         while nz|wend
;     pop bc | pop de | pop hl | pop af
; ret


; void FillMemory(ptr<byte> pDestination, word length, byte b);
cseg
FillMemory_: public FillMemory_
    push af | push hl | push de
        do
            ld (hl),c | inc hl
            dec de
            ld a,e | or a,d
        while nz|wend
    pop de | pop hl | pop af
ret
