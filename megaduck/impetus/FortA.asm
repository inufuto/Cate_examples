include "Vram.inc"
include "Chars.inc"

Width equ 6
Height equ 6+1

ext FortPattern
ext FortY_, FortCharOffset_
ext WaitModeN1

; void SetFortPattern()
dseg
upperCount:
    defb 0
lowerCount:
    defb 0
cseg
SetFortPattern_: public SetFortPattern_
    push af | push hl | push de | push bc
        ld a,(FortY_)
        and a,7
        ld e,a
        ld a,7 | sub a,e
        ld l,a | ld h,0
        add hl,hl ;*2
        ld bc,FortPattern | add hl,bc
        ld e,l | ld d,h

        ld a,(FortCharOffset_)
        add a,Char_Fort-128
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        ld bc,CharRam1 | add hl,bc

        ld c,Width*Height
        do
            ld b,CharHeight*2
            do
                push bc
                    ld a,(de) | inc de
                    ld c,a
                    call WaitModeN1
                    ld (hl),c | inc hl
                pop bc
                dec b
            while nz|wend
            ld a,e | add a,15*2-16 | ld e,a
            ld a,d | adc a,0 | ld d,a
            dec c
        while nz|wend
    pop bc | pop de | pop hl | pop af
ret
