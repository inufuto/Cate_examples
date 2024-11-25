dseg
SubParam: public SubParam
    defs 8


cseg
Sub01: public Sub01
    push hl | push de | push bc
        ld bc,0001h
        ld hl,SubParam
        ld de,26eh
        call 0c92fh
        ld a,(26eh)
    pop bc | pop de | pop hl
ret
