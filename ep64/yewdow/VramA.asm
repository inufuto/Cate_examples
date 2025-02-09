include "Vram.inc"
include "VVram.inc"

ext VVram_
ext CharPattern

VramTop equ Vram+VramRowSize*1

dseg
Backup:
    defs VVramWidth*VVramHeight


cseg
LptSource: public LptSource
    defb 256-200
    defb 52h
    defb 11,51
    defw Vram,0
	defb	00h, 14h, 49h, 6fh, 92h, 29h, 5bh, 0c7h
    defb -50,12h,63,0,0,0,0,0,0,0,0,0,0,0,0,0
    defb -3,16,63,0,0,0,0,0,0,0,0,0,0,0,0,0
    defb -4,16,6,63,0,0,0,0,0,0,0,0,0,0,0,0
    defb -1,90h,63,32,0,0,0,0,0,0,0,0,0,0,0,0
    defb 252,12h,6,63,0,0,0,0,0,0,0,0,0,0,0,0
    defb -50,13h,63,0,0,0,0,0,0,0,0,0,0,0,0,0

InitVram: public InitVram
    ld a,1fh | out (80h),a ; Fixbias 

    ld hl,Lpt/16
    ld a,l | out (82h),a
    ld a,h | or 0c0h | out (83h),a

    ld hl,LptSource
    ld de,Lpt
    ld bc,080h
    ldir
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        ld hl,Vram
        ld de,Vram+1
        ld bc,VramRowSize*VramHeight-1
        ld (hl),0
        ldir

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop de | pop hl | pop af
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            push de
                ld l,a
                ld h,0
                add hl,hl ;*2
                add hl,hl ;*4
                add hl,hl ;*8
                add hl,hl ;*16
                ld de,CharPattern
                add hl,de
            pop de
        ex de,hl
        ld b,CharHeight
        do
            ld a,(de) | inc de
            ld (hl),a | inc hl
            ld a,(de) | inc de
            ld (hl),a
            push bc
                ld bc,VramWidth-1
                add hl,bc
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,VramTop
        exx
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do 
                push bc 
                    ld a,(de)
                    inc de
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            push de
                                ld e,a
                                call Put_
                            pop de
                        exx
                    else
                        exx
                            inc hl
                            inc hl
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth*2
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
