; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
cseg
CopyMemory_: public CopyMemory_
    push hl | push de | push bc
        ex de,hl
        ldir
    pop bc | pop de | pop hl
ret


; void FillMemory(ptr<byte> pDestination, word length, byte b);
cseg
FillMemory_: public FillMemory_
    push hl | push de | push bc
        ld (hl),c
        ld c,e
        ld b,d
        ld e,l
        ld d,h
        inc de
        dec bc
        ldir
    pop bc | pop de | pop hl
ret
