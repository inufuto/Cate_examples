include "MemMap.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, SpritePattern

GVram equ 0c000h
WindowTop equ 1
WindowWidth equ 32

dseg
GTop: public GTop
    defb 0
pCurrentPage_: public pCurrentPage_
    defw 0
TerrainCharOffset: public TerrainCharOffset
    defw 0

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

    ; ld hl,PCGAddress+800h+CharHeight*Char_Color
    ; ld de,ColorPattern
    ; ld c,Char_End-Char_Color
    ; call MakePatternColor
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
            ld b,TPlaneCount
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

; MakePatternColor:
;     push hl | exx | pop hl | exx
;     ld b,c
;     do
;         push bc
;             ld b,PlaneCount
;             do
;                 ld h,CharHeight
;                 do
;                     ld a,(de) | inc de
;                     exx
;                         ld (hl),a | inc hl
;                     exx
;                     dec h
;                 while nz | wend
;                 exx
;                     ld de,800h-CharHeight
;                     add hl,de
;                 exx
;             dwnz
;             exx
;                 ld de,-800h*3+CharHeight
;                 add hl,de
;             exx
;         pop bc
;     dwnz
; ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),e
        inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld a,05h | out (GraphPort),a
        ld a,8fh | out (GraphPort+1),a

        ld hl,Vram0
        ld bc,800h
        ld e,0
        call Clear
        ld hl,Vram0+1000h
        ld bc,800h
        call Clear
        ld hl,Vram0+800h
        ld bc,800h
        ld e,08h
        call Clear

        ld a,10h or 80h | out (GraphPort),a
        xor a | out (GraphPort),a | out (GraphPort),a | out (GraphPort),a
        ld a,20h | ld (GTop),a

        xor a | out (CRTPort),a
        ld a,05h | out (CRTPort+1),a

        ld hl,Vram0 | ld (pCurrentPage_),hl
        ld a,Char_Terrain1-Char_Terrain0 | ld (TerrainCharOffset),a
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    set 2,h
    ld (hl),e
    res 2,h
    inc hl
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push bc
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
        ld (hl),c
        set 2,h
        ld (hl),c
        res 2,h
        inc hl
    pop bc | pop af
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


cseg
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


; void EraseSprite(byte x, byte y);
cseg
EraseSprite_: public EraseSprite_
    push af | push hl | push de | push bc
        call GVramPtr ; ->hl
        call BankG

        ld a,4 or 80h | out (GraphPort),a
        ld a,0fh | out (GraphPort+1),a | out (GraphPort+1),a
        ld a,0ffh | out (GraphPort+1),a
        ld de,VramRowSize-3
        xor a
        ld c,16
        do
            EraseSprite_xCount:
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


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
    push af | push hl | push de | push bc
        exx
            ld c,a ; x
        exx
        call GVramPtr
        call BankG

        ld a,c ; pattern
        exx
            ld h,a | ld l,0
            srl h | rr l
            ld de,SpritePattern | add hl,de
        exx

        ld a,4 or 80h | out (GraphPort),a
        ld a,0fh | out (GraphPort+1),a ; Color Register
        out (GraphPort+1),a ; Function register/screen selection register

        exx
            ld a,c
            and 3
            add a,a
            ld c,a
        exx
        if z
            ld c,16
            do
                ld b,2
                do
                    exx
                        ld e,0
                        ld a,0 or 80h | out (GraphPort),a ; Pattern Register
                        ld b,GPlaneCount
                        do
                            ld a,(hl) | inc hl
                            out (GraphPort+1),a
                            or e | ld e,a
                        dwnz
                        ld a,6 | out (GraphPort),a ; Bit Mask Register
                        ld a,e | out (GraphPort+1),a
                    exx
                    ld a,0ffh
                    ld (hl),a | inc hl
                dwnz
                ld a,l | add a,VramWidth-2 | ld l,a
                ld a,h | adc a,0 | ld h,a
                dec c
            while nz | wend
        else
            ld d,a ;shift
            ld c,16
            do
                ; left
                exx
                    ld e,l | ld d,h
                exx
                ld e,0
                ld a,0 or 80h | out (GraphPort),a ; Pattern Register
                ld b,GPlaneCount
                do
                    ld a,d ; shift
                    exx
                        ld b,a
                        ld a,(hl) | inc hl
                        do
                            sla a
                        dwnz
                    exx
                    out (GraphPort+1),a
                    or e | ld e,a
                dwnz
                ld a,6 | out (GraphPort),a ; Bit Mask Register
                ld a,e | out (GraphPort+1),a
                ld a,0ffh
                ld (hl),a | inc hl
                ; center
                ld e,0
                ld a,0 or 80h | out (GraphPort),a ; Pattern Register
                ld b,GPlaneCount
                do
                    exx
                        ld a,(de) | inc de
                        ld c,a
                        ld b,(hl) | inc hl
                    exx
                    ld a,d ; shift
                    exx
                        do
                            sla c | rl b
                            dec a
                        while nz | wend
                        ld a,b
                    exx
                    out (GraphPort+1),a
                    or e | ld e,a
                dwnz
                ld a,6 | out (GraphPort),a ; Bit Mask Register
                ld a,e | out (GraphPort+1),a
                ld a,0ffh
                ld (hl),a | inc hl
                ; right
                ld e,0
                ld a,0 or 80h | out (GraphPort),a ; Pattern Register
                ld b,GPlaneCount
                do
                    ld a,d ; shift
                    exx
                        ex de,hl
                            ld b,0
                            ld c,(hl) | inc hl
                            do
                                sla c | rl b
                                dec a
                            while nz | wend
                            ld a,b
                        ex de,hl
                    exx
                    out (GraphPort+1),a
                    or e | ld e,a
                dwnz
                ld a,6 | out (GraphPort),a ; Bit Mask Register
                ld a,e | out (GraphPort+1),a
                ld a,0ffh
                ld (hl),a
                ; next row
                ld a,l | add a,VramWidth-2 | ld l,a
                ld a,h | adc a,0 | ld h,a
                dec c
            while nz | wend
        endif
        call BankV
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> NextPage();
cseg
NextPage_: public NextPage_
    push af
        ld hl,(pCurrentPage_)
        ld a,h
        xor 04h
        ld h,a
    pop af
ret


; void SwitchTVram();
cseg
SwitchTVram_: public SwitchTVram_
    push af
        ld a,(pCurrentPage_+1)
        and 04h
        if z
            ld a,high Vram1 | ld (pCurrentPage_+1),a
            xor a | out (CRTPort),a
            ld a,09h | out (CRTPort+1),a
            ld a,Char_Terrain1-Char_Terrain0 | ld (TerrainCharOffset),a
        else
            ld a,high Vram0 | ld (pCurrentPage_+1),a
            xor a | out (CRTPort),a
            ld a,05h | out (CRTPort+1),a
            xor a | ld (TerrainCharOffset),a
        endif
    pop af
ret
