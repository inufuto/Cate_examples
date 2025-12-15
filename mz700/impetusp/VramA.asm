include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext CharPattern

dseg
Backup:
defs VVramWidth*VVramStep*VVramHeight

; void ClearScreen();
cseg
Clear:
    do
        ld (hl),e | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,Vram
        ld bc,VramRowSize*VramHeight
        ld e,0
        call Clear

        ld hl,Atributes
        ld bc,VramRowSize*VramHeight
        ld e,70h
        call Clear

        ld hl,Backup
        ld de,7000h
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),e | inc hl
            ld (hl),d | inc hl
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
CharTable:
    defb 0,61h,62h,63h,64h,65h,66h,67h,68h,69h,6bh,6ah,2fh,2ah,2eh,2dh
    defb 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,4fh,2ch,51h,2bh,57h,49h
    defb 55h,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
    defb 16,17,18,19,20,21,22,23,24,25,26,52h,59h,54h,46h,3ch
PrintC_: public PrintC_
    push af
        ld a,e
        exx
            ld l,a
            ld h,0
            ld de,CharTable - ' '
            add hl,de
            ld a,(hl)
        exx
        ld (hl),a
        set 3,h
        ld (hl),70h
        res 3,h
        inc hl
    pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ex de,hl
            ld h,0
            add hl,hl
            ld bc,CharPattern
            add hl,bc
        ex de,hl
        ld a,(de) | inc de
        ld (hl),a
        ld a,(de)
        set 3,h
        ld (hl),a
        res 3,h
        inc hl
    pop bc | pop de | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram
            ld de,Atributes
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        ld (hl),a
                    exx
                endif
                inc hl

                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        ld (de),a
                    exx
                endif
                inc hl
                exx
                    inc hl
                    inc de
                exx
            dwnz
            exx
                ld a,l | add a,low(VramRowSize-VVramWidth) | ld l,a
                ld e,a
                ld a,h | adc a,high(VramRowSize-VVramWidth) | ld h,a
                add a,8 | ld d,a
            exx
        dec c | while nz | wend
    pop bc | pop de | pop hl | pop af
ret
