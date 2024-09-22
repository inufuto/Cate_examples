include "mz2000.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern

Text equ 0d000h

dseg
Backup:
    defs VVramWidth*VVramHeight

cseg
PatternAddress:
    push de
        ld l,a
        ld h,0
        ld e,l
        ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        add hl,hl ;*48
        ld de,PatternRam
        add hl,de
    pop de
ret


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 4, 7 ; Goal
defb 4, 6 ; Bang
defb 4,7 ; M
defb 4,3 ; A
defb 4,6 ; Z
defb 4,2 ; Y
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

    ld hl,PatternRam+PatternSize*Char_Color
    ld de,ColorPattern
    ld c,Char_End-Char_Color
    call MakePatternColor
ret

MakePatternMono:
    push de
        ld l,a
        ld h,0
        ld e,l
        ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        add hl,hl ;*48
        ld de,PatternRam
        add hl,de
    pop de
    push hl | exx | pop hl | exx
    ld a,c
    do
        push af
            exx
                ld d,a
            exx
            ld c,3
            do
                push de
                    ld h,8
                    do
                        ld a,(de)
                        exx
                            ld e,0
                            bit 0,d
                            if nz
                                or e
                                ld e,a
                            endif
                        exx
                        ld a,(de)
                        exx
                            bit 4,d
                            if nz
                                cpl
                                or e
                                ld e,a
                            endif
                            ld a,e
                            ld e,2
                            do
                                ld bc,400h
                                do
                                    srl c
                                    srl c
                                    rlca
                                    if c
                                        set 7,c
                                        set 6,c
                                    endif
                                dwnz
                                ld (hl),c
                                inc hl
                                dec e
                            while nz | wend
                        exx
                        inc de
                        dec h
                    while nz | wend
                    exx
                        srl d
                    exx
                pop de
                dec c
            while nz | wend
            ex de,hl
                ld de,8
                add hl,de
            ex de,hl
        pop af
    dwnz    
ret

MakePatternColor:
    push hl | exx | pop hl | exx
    do
        ld b,24
        do
            ld a,(de)
            inc de
            exx
                ld e,2
                do
                    ld bc,400h
                    do
                        srl c
                        srl c
                        rlca
                        if c
                            set 7,c
                            set 6,c
                        endif
                    dwnz
                    ld (hl),c
                    inc hl
                    dec e
                while nz | wend
            exx
        dwnz
        dec c
    while nz | wend
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld a,0c0h | out (PortPIO_A),a
        ld hl,Text
        ld bc,2000
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
        ld a,080h | out (PortPIO_A),a

        ld a,1
        do
            out (AccessPlane),a
            ld hl,0c000h
            ld de,0c001h
            ld bc,640/8*200-1
            ld (hl),0
            ldir
            inc a
            cp 4
        while nz | wend
        xor a
        out (AccessPlane),a

        ld hl,Backup
        ld bc,VVramWidth * VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put:
    ex de,hl
        call PatternAddress
    ex de,hl
    ; di
        ld a,1
        do
            out (AccessPlane),a
            ex af,af'
                ld a,CharHeight
                ld bc,VramWidth-1
                do
                    ld i,a
                    ; ld (Put_count+1),a
                    ld a,(de) | inc de
                    ld (hl),a | inc hl
                    ld a,(de) | inc de
                    ld (hl),a | add hl,bc
                    ld a,i
                    dec a
                while nz | wend
                ld bc,-VramWidth*CharHeight
                add hl,bc
            ex af,af'
            inc a
            cp 4
        while nz | wend
        xor a
        out (AccessPlane),a
    ; ei
ret

Put_: public Put_
    push af | push hl | push de | push bc
        ld a,e
        call Put
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld a,0c0h | out (PortPIO_A),a

        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,Vram
            ld de,Text
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do 
                push bc 
                    ld a,(de) | inc de
                    ld c,a
                    or a
                    jr z,VVramToVram_G
                    inc a
                    if z
                        ld c,0
                        ld a,1eh
                    else
                        xor a
                    endif
                    VVramToVram_G:
                    exx
                        ld (de),a | inc de
                    exx
                    ld a,c
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            push de
                                ld e,a
                                ld a,080h | out (PortPIO_A),a
                                call Put_
                                ld a,0c0h | out (PortPIO_A),a
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
                    ex de,hl
                        ld bc,40-VVramWidth
                        add hl,bc
                    ex de,hl
                pop bc
            exx
            dec c
        while nz | wend
        
        ld a,080h | out (PortPIO_A),a
    pop bc | pop de | pop hl | pop af
ret
