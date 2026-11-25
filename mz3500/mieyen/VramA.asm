include "Share.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext HaltSub, ResumeSub
ext MonoPattern, ColorPattern
ext VVramBack_, VVramFront_

VramTop equ Vram+VramRowSize*1

dseg
Backup:
    defs VVramWidth*VVramHeight


cseg
ColorTable:
defb 32, 7 ; Ascii
defb 16, 5 ; Logo
defb 16, 1 ; Wall
defb 32,3 ; Monster
defb 4,6 ; Dot
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
        push hl | push bc
            call MakePatternMono
        pop bc | pop hl
    wend

    ld hl,ColorPattern
    ld b,Char_End-Char_Color
    call MakePatternColor
ret
MakePatternMono: ; a=char code, b=count, c=color
    push af
        ld a,c ; color
        exx
            ld c,a
        exx
    pop af
    do
        push af
            call HaltSub

            ld (MainShareRam+Share_Char),a
            ld a,SubCommand_DefChar | ld (MainShareRam+Share_Command),a
            ld hl,MainShareRam+Share_Pattern

            exx
                ld b,c
            exx
            ld c,PlaneCount
            do
                push de | push bc
                    ld b,CharHeight
                    do
                        ld a,(de) | inc de
                        push de
                            ld e,a
                            ld d,0
                            exx
                                bit 0,b
                            exx
                            if nz
                                ld a,d | or e | ld d,a
                            endif
                            exx
                                bit 4,b
                            exx
                            if nz
                                ld a,e
                                cpl
                                or d
                                ld d,a
                            endif
                            ld a,d
                            call DoubleADe
                            ld (hl),e | inc hl
                            ld (hl),d | inc hl
                        pop de
                    dwnz
                pop bc | pop de
                exx
                    srl b
                exx
                dec c
            while nz | wend

            call ResumeSub

            ld a,e | add a,CharHeight | ld e,a
            ld a,d | adc a,0 | ld d,a
        pop af
        inc a
    dwnz    
ret
MakePatternColor: ; a=char code, b=count
    do
        push af
            call HaltSub

            ld (MainShareRam+Share_Char),a
            ld a,SubCommand_DefChar | ld (MainShareRam+Share_Command),a
            ld hl,MainShareRam+Share_Pattern

            ld c,CharHeight*PlaneCount
            do
                ld a,(de) | inc de
                push de
                    call DoubleADe
                    ld (hl),e | inc hl
                    ld (hl),d | inc hl
                pop de
                dec c
            while nz | wend

            call ResumeSub
        pop af
        inc a
    dwnz    
ret

DoubleADe:
    push bc
        ld de,0
        ld b,8
        do
            srl d | rr e
            srl d | rr e
            rlca
            if c
                set 7,d
                set 6,d
            endif
        dwnz
    pop bc
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl), 0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        call HaltSub
        ld a,SubCommand_Clear | ld (MainShareRam+Share_Command),a
        call ResumeSub

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af
        call HaltSub
        ld a,SubCommand_DrawChar | ld (MainShareRam+Share_Command),a
        ld a,e | ld (MainShareRam+Share_Char),a
        ld (MainShareRam+Share_Address),hl
        call ResumeSub
    pop af
    inc hl
ret


; word PrintC(word vram, byte c);
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
        ld e,c
        call Put_
    pop bc | pop de | pop af
ret

; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,VramTop
        exx
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
                                ld e,a
                                call Put_
                            pop de
                        exx
                    else
                        exx
                            inc hl
                        exx
                    endif
                    VVramToVram_next:
                    inc hl
                pop bc
            dwnz
            exx
                push bc
                    ld bc,VramRowSize-VVramWidth*VramStep
                    add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
