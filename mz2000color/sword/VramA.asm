include "mz2000.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext VVramFront_
ext PollTimer_

Text equ 0d000h

dseg
PatternRam: public PatternRam
    defs PatternSize*Char_End
Backup:
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
        add hl,hl ;*48
        ld de,PatternRam | add hl,de
    pop de
ret

cseg
DoubleADe:
    push bc
        ld de,0
        ld b,8
        do
            sla e | rl d
            sla e | rl d
            rlca
            if c
                set 0,e
                set 1,e
            endif
        dwnz
    pop bc
ret

DoubleBytes:
    do
        ld a,(hl) | inc hl
        exx
            call DoubleADe
            ld (hl),e | inc hl
            ld (hl),d | inc hl
        exx
        dec bc
        ld a,c | or b
    while nz | wend
ret

cseg
ColorTable:
defb 31, 7 ; Ascii
defb 15, 6 ; Logo
defb 2, 1 ; Fence
defb 4, 1 ; Wall
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
    exx
        ld hl,PatternRam+PatternSize*Char_Color
    exx
    ld bc,PatternSize/2*(Char_End-Char_Color)
    call DoubleBytes
ret

MakePatternMono: public MakePatternMono
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
                        push de
                            call DoubleADe
                            ld (hl),e | inc hl
                            ld (hl),d | inc hl
                        pop de
                        srl c
                    dwnz
                pop de
            pop bc
            dec c
        while nz | wend
    dwnz    
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
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld a,0c0h
        out (PortPIO_A),a

        ld hl,Text
        ld bc,2000
        call Clear

        ld a,080h
        out (PortPIO_A),a

        ld a,1
        do
            out (AccessPlane),a
            ld hl,0c000h
            ld bc,4000h
            call Clear
            inc a
            cp 4
        while nz | wend
        xor a
        out (AccessPlane),a

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ; ld hl,VVram_
        ; ld bc,VVramWidth*VVramHeight*2
        ; call Clear
    pop bc | pop de | pop hl | pop af
ret


Put:
    ex de,hl
        call PatternPtr
    ex de,hl
    ld b,CharHeight
    do
        ld a,1
        do
            out (AccessPlane),a
            ex af,af'
                ld a,(de) | inc de
                ld (hl),a | inc hl
                ld a,(de) | inc de
                ld (hl),a | dec hl
            ex af,af'
            inc a
            cp 4
        while nz | wend
        xor a | out (AccessPlane),a
        ld a,l | add a,VramWidth | ld l,a
        ld a,h | adc a,0 | ld h,a
    dwnz
    ld a,l | sub low(VramRowSize-VramStep) | ld l,a
    ld a,h | sbc a,high(VramRowSize-VramStep) | ld h,a
ret

; word Put(word vram, byte c);
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call Put
    pop bc | pop de | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push de | push bc
        push hl
            ld a,e
            ld bc,31*256
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


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*2
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do 
                ld a,(de) | inc de
                cp Char_End
                jr nc,VVramToVram_write
                cp (hl)
                if nz
                    VVramToVram_write:
                    ld (hl),a
                    exx
                        call Put
                    exx
                else
                    exx
                        inc hl | inc hl
                    exx
                endif
                inc hl
            dwnz
            exx
                ld a,l | add a,low(VramRowSize-VramStep*VVramWidth) | ld l,a
                ld a,h | adc a,high(VramRowSize-VramStep*VVramWidth) | ld h,a
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
