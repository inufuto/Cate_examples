include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Chars

dseg
Backup: defs VVramWidth*VVramHeight

; void ClearScreen();
cseg
Clear:
    ld bc,VramWidth*VramHeight
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        call Clear

        ld hl,Atributes
        call Clear

        ld hl,Backup
        call Clear

        ld hl,VVram_
        call Clear
    pop bc | pop hl | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld de,Vram+VramRowSize*1
        exx
        ld c, VVramHeight ; vertical count    
        do
            ld b,VVramWidth
            do 
                ld a,(de)
                inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        push hl | push bc
                            ld l,a
                            ld h,0
                            add hl,hl
                            ld bc,Chars
                            add hl,bc
                            ld a,(hl)
                            inc hl
                            ld (de),a
                            ld a,(hl)
                            set 3,d
                            ld (de),a
                            res 3,d
                        pop bc | pop hl
                    exx
                endif
                exx
                    inc de
                exx
                inc hl
            dwnz
            exx
                ex de,hl
                    push bc
                        ld bc,VramRowSize-VVramWidth
                        add hl,bc
                    pop bc
                ex de,hl
            exx
            dec c
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
    push af | push hl | push de | push bc
        ex de,hl
            ld h,0
            add hl,hl
            ld bc,Chars
            add hl,bc
        ex de,hl
        ld a,(de)
        inc de
        ld (hl),a
        ld a,(de)
        set 3,h
        ld (hl),a
    pop bc | pop de | pop hl | pop af
    inc hl
ret
