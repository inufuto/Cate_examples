include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Status_
ext CharPattern

VramTop equ Vram+VramRowSize*0

dseg
Backup: defs VVramWidth*VVramHeight


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,VramOrg
        ld bc,VramRowSize*VramHeight
        do
            ld (hl),20h | inc hl
            dec bc
            ld a,c | or b
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,Status_
        ld bc,VramWidth*2
        call Clear
    pop bc | pop hl | pop af
ret


Put1: ;(hl,a)
    ex de,hl
        ld l,a | ld h,0
        ld c,l | ld b,h
        add hl,hl ;*2
        add hl,bc ;*3
        ld bc,CharPattern | add hl,bc
    ex de,hl
    ld b,3
    do
        ld a,(de) | inc de
        ld (hl),a | inc hl
    dwnz
ret

; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call Put1
    pop bc | pop de | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_+VVramWidth*0
        ld hl,Backup
        exx
            ld hl,VramTop
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
                        call Put1
                    exx
                else
                    exx
                        inc hl | inc hl | inc hl
                    exx
                endif
                inc hl
            dwnz
            exx
                ld de,VramRowSize-VVramWidth*VramStep | add hl,de
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    ld (hl),e
    inc hl
ret


; void StatusToVram();
cseg
StatusToVram_: public StatusToVram_
    push af | push hl | push de | push bc
        ld hl,Status_
        ld de,Vram
        ld c,2
        do
            ld b,60
            do
                ld a,(hl) | inc hl
                or a
                jr z,skip
                cp 80h
                if nz
                    ld (de),a
                endif
                skip:
                inc de
            dwnz
            ; inc de | inc de | inc de | inc de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void EraseBackup();
cseg
EraseBackup_: public EraseBackup_
    push af | push hl | push bc
        ld hl,Backup
        ld bc,VVramWidth*2
        do
            ld (hl),0ffh | inc hl
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop hl | pop af
ret
