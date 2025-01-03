include "MemMap.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext FillMemory_
ext Ground_

GVram equ 0c000h
WindowTop equ 1
WindowWidth equ 32

dseg
GTop: public GTop
    defb 0

cseg
ColorTable:
defb 64, 7 ; Ascii
defb 16, 5 ; Logo
defb 16, 1 ; Wall
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
        push af | push hl | push bc
            call MakePatternMono
        pop bc | pop hl | pop af
        add a,b
    wend

    ld hl,PCGAddress+800h+CharHeight*Char_Color
    ld de,ColorPattern
    ld c,Char_End-Char_Color
    call MakePatternColor
ret

MakePatternMono:
    push de
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        ld de,PCGAddress+800h
        add hl,de
    pop de
    push hl | exx | pop hl | exx
    do
        push bc
            ld b,PlaneCount
            do
                push de
                    ld h,CharHeight
                    do
                        ld a,(de) | inc de
                        ld l,0
                        bit 0,c
                        if nz
                            or l | ld l,a
                        endif
                        bit 4,c
                        if nz
                            cpl
                            or l | ld l,a
                        endif
                        ld a,l
                        exx
                            ld (hl),a | inc hl
                        exx
                        dec h
                    while nz | wend
                    exx
                        ld de,800h-CharHeight
                        add hl,de
                    exx
                    srl c
                pop de
            dwnz
            ex de,hl
                ld de,CharHeight
                add hl,de
            ex de,hl
            exx
                ld de,-800h*3+CharHeight
                add hl,de
            exx
        pop bc
    dwnz
ret

MakePatternColor:
    push hl | exx | pop hl | exx
    ld b,c
    do
        push bc
            ld b,PlaneCount
            do
                ld h,CharHeight
                do
                    ld a,(de) | inc de
                    exx
                        ld (hl),a | inc hl
                    exx
                    dec h
                while nz | wend
                exx
                    ld de,800h-CharHeight
                    add hl,de
                exx
            dwnz
            exx
                ld de,-800h*3+CharHeight
                add hl,de
            exx
        pop bc
    dwnz
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld a,05h | out (GraphPort),a
        ld a,8fh | out (GraphPort+1),a

        ld hl,Vram0
        ld de,800h
        ld c,0
        call FillMemory_
        ld hl,Vram0+1000h
        call FillMemory_
        ld hl,Vram0+800h
        ld c,08h
        call FillMemory_

        ld a,10h or 80h | out (GraphPort),a
        xor a | out (GraphPort),a | out (GraphPort),a | out (GraphPort),a
        ld a,20h | ld (GTop),a

        xor a | out (CRTPort),a
        ld a,05h | out (CRTPort+1),a
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> VramPtr(byte x, byte y);
cseg
VramPtr_: public VramPtr_
    push af | push bc
        ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,e ;*5
        ld l,a
        ld h,0
        add hl,hl ;*10
        add hl,hl ;*20
        add hl,hl ;*40
        ld b,0
        add hl,bc
        ld bc,Vram0
        add hl,bc
    pop bc | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    set 2,h
    ld (hl),e
    res 2,h
    inc hl
ret


; void SwitchGVram();
cseg
SwitchGVram_: public SwitchGVram_
    push af
        do
            ld a,(CRTPort)
            and 1
        while nz | wend

        ld a,11h | out (GraphPort),a
        ld a,(GTop) | out (GraphPort+1),a
        or a
        if z
            ld a,20h
        else
            xor a
        endif
        ld (GTop),a
    pop af
ret


GVramPtr:
    rrca | rrca | and 3fh
    ld b,a
    ld d,0
    ld l,e
    ld h,d
    add hl,hl ;*2
    add hl,hl ;*4
    add hl,de ;*5
    add hl,hl ;*10
    add hl,hl ;*20
    add hl,hl ;*40
    add hl,hl ;*80
    ld e,b
    ld d,0
    add hl,de
    ld de,GVram+VramWidth*CharHeight*0
    ld a,(GTop) | add a,d | ld d,a
    add hl,de
ret

BankG:
    di
        ld a,6 | out (MemMapPort),a
        ld a,MemMap_GVram | out (MemMapPort+1),a
        inc a | out (MemMapPort+1),a
    ei
ret

BankV:
    di
        ld a,6 | out (MemMapPort),a
        ld a,MemMap_PCG | out (MemMapPort+1),a
        ld a,MemMap_Text | out (MemMapPort+1),a
    ei
ret

EraseSprite_: public EraseSprite_
    push af | push hl | push de | push bc
        call GVramPtr
        call BankG

        ld a,4 or 80h | out (GraphPort),a
        ld a,0fh | out (GraphPort+1),a | out (GraphPort+1),a
        ld a,0ffh | out (GraphPort+1),a
        ld de,VramRowSize-3
        xor a
        ld c,16
        do
            ld b,3
            do
                ld (hl),a | inc hl
            dwnz
            add hl,de
            dec c
        while nz | wend
        call BankV
    pop bc | pop de | pop hl | pop af
ret

ShiftLow:
    ld e,a
    ld a,c
    or a
    do | while nz
       sla e
       dec a
    wend
ret


ShiftHigh:
    ld d,a
    ld a,8
    sub c
    do | while nz
       srl d
       dec a
    wend
ret

DrawSprite_: public DrawSprite_
    push af | push hl | push de | push bc
        exx
            ld c,a
        exx
        call GVramPtr
        call BankG

        ld a,c
        exx
            ld h,a
            ld l,0
            srl h | rr l
            ld de,SpritePattern
            add hl,de

            ld a,c
            and 3
            add a,a
            ld c,a
        exx

        ld a,4 or 80h | out (GraphPort),a
        ld a,0fh | out (GraphPort+1),a
        out (GraphPort+1),a

        ld c,16
        do
            ld b,2
            do
                exx
                    ld a,(hl)
                    call ShiftLow
                    ld a,e
                    ld b,e
                exx
                or a
                if nz
                    ld a,6 | out (GraphPort),a
                    exx
                        ld a,b
                        out (GraphPort+1),a
                        inc hl
                    exx
                    ld a,0 or 80h| out (GraphPort),a
                    ld e,3
                    do
                        exx
                            ld a,(hl) | inc hl
                            call ShiftLow
                            ld a,e | out (GraphPort+1),a
                        exx
                        dec e
                    while nz | wend
                    exx
                        ld a,b | out (GraphPort+1),a
                        dec hl | dec hl | dec hl | dec hl
                    exx
                    ld a,0ffh | ld (hl),a
                endif
                inc hl

                exx
                    ld a,(hl)
                    call ShiftHigh
                    ld a,d
                    ld b,d
                exx
                or a
                if nz
                    ld a,6 | out (GraphPort),a
                    exx
                        ld a,b
                        out (GraphPort+1),a
                        inc hl
                    exx
                    ld a,0 or 80h| out (GraphPort),a
                    ld e,3
                    do
                        exx
                            ld a,(hl) | inc hl
                            call ShiftHigh
                            ld a,d | out (GraphPort+1),a
                        exx
                        dec e
                    while nz | wend
                    exx
                        ld a,b | out (GraphPort+1),a
                    exx
                    ld a,0ffh | ld (hl),a
                else
                    exx
                        inc hl | inc hl | inc hl | inc hl
                    exx
                endif
            dwnz
            ld de,VramRowSize-2
            add hl,de
            dec c
        while nz | wend
        call BankV
    pop bc | pop de | pop hl | pop af
ret


; byte ReadVram(ptr<byte> pVram);
cseg
ReadVram_: public ReadVram_
    ld a,(hl)
ret
