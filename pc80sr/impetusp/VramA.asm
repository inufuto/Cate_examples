include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext VVramFront_, VVramBack_

Offscreen equ VramBack+8000

dseg
PatternRam: public PatternRam
    defs PatternSize*Char_End
BackupBack:
    defs VVramWidth*VVramHeight
BackupFront:
    defs VVramWidth*VVramHeight

cseg
PatternPtr:
    push de
        ld l,a | ld h,0
        ld e,l | ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld de,PatternRam | add hl,de
    pop de
ret

cseg
ColorTable:
defb 30, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
    xor a
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld b,(hl)
        inc b | dec b
    while nz
        inc hl
        ld c,(hl)
        inc hl
        push af | push hl | push bc
            call MakePatternMono
        pop bc | pop hl | pop af
        add a,b
    wend

    ld hl,ColorPattern
    ld de,PatternRam+PatternSize*Char_Color
    ld bc,PatternSize*(Char_End-Char_Color)
    ldir
    
    call InitOffscreen
ret

MakePatternMono:
    call PatternPtr
    ld a,c ; color
    exx
        ld c,a
    exx
    do
        ld c,CharHeight
        do
            push bc
                ld a,(de) | inc de
                push de
                    ld e,a
                    exx
                        ld a,c ; color
                    exx
                    ld c,a ; color
                    ld b,PlaneCount
                    do
                        ld d,0 ; byteValue
                        bit 0,c
                        if nz
                            ld a,d | or e | ld d,a
                        endif
                        bit 4,c
                        if nz
                            ld a,e
                            cpl
                            or d
                            ld d,a
                        endif
                        ld a,d
                        ld (hl),d | inc hl
                        srl c
                    dwnz
                pop de
            pop bc
            dec c
        while nz | wend
    dwnz    
ret

InitOffscreen:
    ld hl,Offscreen
    ld de,PatternRam+PatternSize*Char_Terrain
    exx
        ld bc,CharHeight*(Char_End-Char_Terrain)
    exx
    do
        di
            ld bc,35ch
            do
                out (c),a
                ld a,(de) | inc de
                ld (hl),a
                inc c
            dwnz
            out (c),a
        ei
        inc hl
        exx
            dec bc
            ld a,c | or b
        exx
    while nz | wend
ret


; void ClearScreen();
cseg
Clear:
    ld (hl),0
    ld e,l | ld d,h
    inc de
    dec bc
    ldir
ret
ClearScreen_:   public ClearScreen_
    push af | push hl | push de | push bc
        di
            ld a,0c4h | out (33h),a
            xor a | out (34h),a
            ld a,80h | out (35h),a

            ld hl,VramBack
            ld de,VramBack+1
            ld bc,8000-1
            ld (hl),0ffh
            ldir

            ld hl,VramFront
            ld de,VramFront+1
            ld bc,8000-1
            ld (hl),0ffh
            ldir

            ld a,90h | out (35h),a
            ld a,84h | out (33h),a
        ei

        ld hl,BackupBack
        ld bc,VVramWidth*VVramHeight*2
        call Clear

        ; ld hl,VVramBack_
        ; ld bc,VVramWidth*VVramHeight*2
        ; call Clear
    pop bc | pop de | pop hl | pop af
ret

cseg
Put:
    cp Char_Terrain
    if nc
        ex de,hl
            sub Char_Terrain
            ld l,a | ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            ld a,l | add a,low(Offscreen) | ld l,a
            ld a,h | adc a,high(Offscreen) | ld h,a
        ex de,hl
        di
            in a,(33h) | or 40h | out (33h),a
            ld a,90h | out (35h),a
            ld b,CharHeight
            do
                ld a,(de) | inc de
                ld (hl),a
                ld a,l | add a,VramWidth | ld l,a
                ld a,h | adc a,0 | ld h,a
            dwnz
            xor a | out (35h),a
            in a,(33h) | and not 40h | out (33h),a

            ld a,l | sub low(VramWidth*CharHeight-1) | ld l,a
            ld a,h | sbc a,high(VramWidth*CharHeight-1) | ld h,a
        ei
    else
        ex de,hl
            call PatternPtr
        ex de,hl
        di
            ld b,CharHeight
            do
                ld c,5ch
                do
                    out (c),a
                    ld a,(de) | inc de
                    ld (hl),a
                    inc c
                    ld a,c
                    cp 5fh
                while nz | wend
                out (c),a
                ld a,l | add a,VramWidth | ld l,a
                ld a,h | adc a,0 | ld h,a
            dwnz
            ld a,l | sub low(VramRowSize) | ld l,a
            ld a,h | sbc a,high(VramRowSize) | ld h,a
        ei
        inc hl
    endif
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call Put
    pop bc | pop de | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push de | push bc
        push hl
            ld a,e
            ld bc,30*256
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
        pop hl
        ld a,c
        call Put
    pop bc | pop de | pop af
ret


cseg
VVramToVram:
    ld c, VVramHeight
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
                            call Put
                        pop de
                    exx
                else
                    exx
                        inc hl
                    exx
                endif
                inc hl
            pop bc
        dwnz
        exx
            ld a,l | add a,low(VramRowSize-VVramWidth) | ld l,a
            ld a,h | adc a,high(VramRowSize-VVramWidth) | ld h,a
        exx
        dec c
    while nz | wend
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramBack_
        ld hl,BackupBack
        exx
            ld hl,VramBack+VramRowSize*0
        exx
        call VVramToVram

        ld de,VVramFront_
        ld hl,BackupFront
        exx
            ld hl,VramFront+VramRowSize*0
        exx
        call VVramToVram
    pop bc | pop de | pop hl | pop af
ret
