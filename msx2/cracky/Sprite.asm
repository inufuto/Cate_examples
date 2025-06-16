include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext ColorSpritePattern, MonoSpritePattern

Top equ 8*1-1
HiddenY equ 192

Sprite_Fixed equ 0
Sprite_Remain equ 0
Sprite_Color equ 4
Sprite_Man equ 4
Sprite_Mono equ 6
Sprite_Monster equ 6
Sprite_End equ 10


cseg
InitSprites: public InitSprites
    ld bc,0e201h
    call WRTVDP

    ld hl,ColorSpritePattern
    ld de,Vram_SpriteGenerator
    ld b,Pattern_Mono
    do
        push bc
            push hl | push de
                ld bc,32
                call LDIRVM
            pop de | pop hl
            ld bc,32+16
            add hl,bc
            ex de,hl
                ld bc,32
                add hl,bc
            ex de,hl
        pop bc
    dwnz

    ld hl,MonoSpritePattern
    ld de,Vram_SpriteGenerator+32*Pattern_Mono
    ld bc,32*(Pattern_End-Pattern_Mono)
    call LDIRVM
; ret


; void HideSprite(byte index);
HideAllSprites_: public HideAllSprites_
	push af | push hl | push bc
        ld a,(VdpOutPort) | ld c,a

        ld hl,Vram_SpriteAttribute or 4000h
        ld a,HiddenY
        ld b,Sprite_End
        do
            inc c
            out (c),l
            out (c),h
            dec c
            out (c),a
            inc hl | inc hl | inc hl | inc hl
        dwnz
    pop	bc | pop hl | pop af
    ; call UpdateSprites_
ret


ToSpritePtr: ; a->de,hl
    add a,a ;*2
    add a,a ;*4
    ld e,a | ld d,40h or high Vram_SpriteAttribute 
    ld l,a | ld h,0
    add hl,hl ;*8
    add hl,hl ;*16
    ld a,h | add a,40h or high Vram_SpriteColor | ld h,a
ret

ToPatternPtr: ; e->hl
    ld a,e ; pattern
    add a,a ;*2
    add a,e ;*3
    ld l,a | ld h,0
    add hl,hl ;*6
    add hl,hl ;*12
    ld a,l | add a,low ColorSpritePattern | ld l,a
    ld a,h | adc a,high ColorSpritePattern | ld h,a
ret

PrepareAttribute:
    exx
        inc c
        out (c),e
        out (c),d
        dec c
        inc de | inc de | inc de | inc de
    exx
ret

PrepareColor:
    exx
        inc c
        out (c),l
        out (c),h
        dec c
        ld a,l | add a,16 | ld l,a
        ld a,h | adc a,0 | ld h,a
    exx
ret


; void ShowSpriteC(ptr<Movable> pMovable, byte pattern);
cseg
ShowSpriteC_: public ShowSpriteC_
	push af | push hl | push de | push bc
        sla e | sla e
        call ToPatternPtr
        exx
            ld a,(ix+2)  ; index
            call ToSpritePtr
            ld a,(VdpOutPort)
            ld c,a
        exx
        ld c,a
        di
            ld d,00h
            do
                call PrepareAttribute
                ld a,(ix+1) ; y
                add a,Top
                out (c),a
                ld a,(ix+0) ; x
                out (c),a
                nop
                out (c),e ; pattern
                inc e | inc e | inc e | inc e
                call PrepareColor
                ld a,l | add a,32 | ld l,a
                ld a,h | adc a,0 | ld h,a
                ld b,16
                do
                    ld a,(hl) | inc hl
                    or d
                    out (c),a
                dwnz
                ld a,d
                xor 40h
                ld d,a
            while nz | wend
        ei
    pop bc | pop de | pop hl | pop af
ret


; void ShowSpriteM(ptr<Movable> pMovable, byte pattern, byte color);
cseg
ShowSpriteM_: public ShowSpriteM_
	push af | push hl | push de | push bc
                                            _deb:public _deb
        ld d,c
        sla e | sla e
        exx
            ld a,(ix+2)  ; index
            call ToSpritePtr
            ld a,(VdpOutPort)
            ld c,a
        exx
        ld c,a
        di
            call PrepareAttribute
            ld a,(ix+1) ; y
            add a,Top
            out (c),a
            ld a,(ix+0) ; x
            out (c),a
            nop
            out (c),e ; pattern
            call PrepareColor
            ld b,16
            do
                out (c),d
            dwnz
        ei
    pop bc | pop de | pop hl | pop af
ret


; void ShowSpriteF(byte index, byte x, byte y, byte pattern);
dseg
ShowSpriteF_@Param3: public ShowSpriteF_@Param3
ShowSpriteF_pattern:
    defb 0
cseg
ShowSpriteF_: public ShowSpriteF_
    push af | push hl | push de | push bc
        exx
            call ToSpritePtr
            ld a,(VdpOutPort)
            ld c,a
        exx
        ld d,c ; y
        ld b,e ; x
        ld c,a
        ex af,af'
            ld a,(ShowSpriteF_pattern)
            add a,a ;*2
            add a,a ;*4
            ld e,a
        ex af,af'
        call ToPatternPtr
        ld e,b ; x
        di
            ld b,00h
            do
                call PrepareAttribute
                out (c),d ; y
                nop
                out (c),e ; x
                ex af,af'
                    out (c),a ; pattern
                    add a,4
                ex af,af'
                call PrepareColor
                ld a,l | add a,32 | ld l,a
                ld a,h | adc a,0 | ld h,a
                push de
                    ld e,16
                    do
                        ld a,(hl) | inc hl
                        or b
                        out (c),a
                        dec e
                    while nz | wend
                pop de
                ld a,b
                xor 40h
                ld b,a
            while nz | wend
        ei
    pop bc | pop de | pop hl | pop af
ret


HideSprite_: public HideSprite_
	push af | push hl | push de | push bc
        exx
            call ToSpritePtr
            ld a,(VdpOutPort)
            ld c,a
        exx
        ld c,a
        di
            call PrepareAttribute
            ld a,HiddenY
            out (c),a
        ei
    pop bc | pop de | pop hl | pop af
ret
