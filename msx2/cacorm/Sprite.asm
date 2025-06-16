include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext ColorSpritePattern, MonoSpritePattern

Top equ 8*2-1
HiddenY equ 192

Sprite_Color equ 0
Sprite_Man equ 0
Sprite_Mono equ 2
Sprite_Monster equ 2
Sprite_Point equ 6
Sprite_Increaser equ 10
Sprite_End equ 11+1

Offset_y equ 0
Offset_x equ 1
Offset_name equ 2
Offset_colors equ 3
UnitSize equ Offset_colors+16

    dseg
Sprites: public Sprites
    defs UnitSize*(Sprite_End-Sprite_Color)
FirstIndex:
    defs 1
FirstAddress:
    defs 2

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
	push hl | push de | push bc
        ; di
            ld hl,Sprites
            ld (FirstAddress),hl
            ld de,UnitSize
            ld b,Sprite_End-Sprite_Color
            do
                ld (hl),HiddenY
                add hl,de
            dwnz
            xor a
            ld (FirstIndex),a
        ; ei
    pop	bc | pop de | pop hl
    call UpdateSprites_
ret


ToSpritePtr: ; l->hl
    ld h,0
    ld c,l | ld b,h
    add hl,hl   ;*2
    ld e,l | ld d,h
    add hl,hl   ;*4
    add hl,hl   ;*8
    add hl,hl   ;*16
    add hl,de   ;*18
    add hl,bc   ;*19
    ld de,Sprites-UnitSize*Sprite_Color
    add hl,de
ret

ToPatternPtr: ; e->hl
    ld a,e ; pattern
    add a,a ;*2
    add a,e ;*3
    ld l,a | ld h,0
    add hl,hl ;*6
    add hl,hl ;*12
    add hl,hl ;*24
    add hl,hl ;*48
    ld bc,ColorSpritePattern | add hl,bc
ret


; void ShowSpriteM(ptr<Movable> pMovable, byte pattern, byte color);
cseg
ShowSpriteC_: public ShowSpriteC_
	push af | push hl | push de | push bc
        push de
            call ToPatternPtr
            ld c,l | ld b,h
            push bc
                ld l,(ix+2)  ; index
                call ToSpritePtr
            pop bc
        pop de
        ; di
            sla e | sla e
            ld d,00h
            do
                ld a,(ix+1) ; y
                add a,Top
                ld (hl),a
                inc hl 
                ld a,(ix+0) ; x
                ld (hl),a 
                inc hl
                ld (hl),e ; pattern
                inc hl
                push de
                    ld a,c | add a,32 | ld c,a
                    ld a,b | adc a,0 | ld b,a
                    ld e,16
                    do
                        ld a,(bc) | inc bc
                        or d
                        ld (hl),a | inc hl
                        dec e
                    while nz | wend
                pop de
                inc e | inc e | inc e | inc e
                ld a,d
                xor 40h
                ld d,a
            while nz | wend
        ; ei
    pop bc | pop de | pop hl | pop af
ret


; void ShowSpriteM(ptr<Movable> pMovable, byte pattern, byte color);
cseg
ShowSpriteM_: public ShowSpriteM_
	push af | push hl | push de | push bc
        push de | push bc
            ld l,(ix+2)  ; index
            call ToSpritePtr
        pop bc | pop de
        ; di
            ld a,(ix+1) ; y
            add a,Top
            ld (hl),a
            inc hl 
            ld a,(ix+0) ; x
            ld (hl),a 
            inc hl
            sla e | sla e
            ld (hl),e ; pattern
            inc hl 
            ld b,16
            do
                ld (hl),c | inc hl
            dwnz
        ; ei
    pop bc | pop de | pop hl | pop af
ret


HideSprite_: public HideSprite_
	push af | push hl | push de | push bc
        ld l,a  ; index
        call ToSpritePtr
        ; di
            ld (hl),HiddenY
        ; ei
    pop bc | pop de | pop hl | pop af
ret


; void HideAllSprites();
cseg
UpdateSprite:
    di
        exx
            inc c
            out (c),e
            out (c),d
            dec c
            inc de | inc de | inc de | inc de
        exx
        inc hl
        dec a
        out (c),a
        ld b,(hl) | inc hl ; x
        out (c),b
        ld b,(hl) | inc hl ; pattern
        out (c),b
    ei
    di
        exx
            inc c
            out (c),l
            out (c),h
            dec c
            push de
                ld de,16
                add hl,de
            pop de
        exx
        ld b,16
        do
            ld a,(hl) | inc hl ; color
            out (c),a
        dwnz
    ei
ret
UpdateSprites_: public UpdateSprites_
    push af | push hl | push de | push bc
        ld a,(VdpOutPort)
        ld c,a
        exx
            ld c,a
            ld hl,(Vram_SpriteColor+16*Sprite_Color)  or 4000h
            ld de,(Vram_SpriteAttribute+4*Sprite_Color) or 4000h
            inc c
            ld a,1 | out (c),a
            ld a,14 or 80h | out (c),a
            dec c
        exx

        ld a,(FirstIndex) | ld e,a
        ld hl,(FirstAddress)
        ld d,Sprite_End-Sprite_Color
        do
            ld a,e
            cp Sprite_Mono-Sprite_Color
            if nc
                ld a,(hl) ; y
                cp HiddenY
                if c
                    call UpdateSprite
                    ld a,(hl) ; y
                    call UpdateSprite
                else
                    push de
                        ld de,UnitSize*2
                        add hl,de
                    pop de
                endif
                inc e
            else
                ld a,(hl) ; y
                cp HiddenY
                if c
                    call UpdateSprite
                else
                    push de
                        ld de,UnitSize
                        add hl,de
                    pop de
                endif
            endif
            inc e
            ld a,e
            cp Sprite_End-Sprite_Color
            if nc
                sub Sprite_End-Sprite_Color
                push de
                    ld de,-UnitSize*(Sprite_End-Sprite_Color)
                    add hl,de
                pop de
            endif
            ld e,a
            dec d
        while nz | wend

        exx
            di
                inc c
                out (c),e
                out (c),d
                dec c
                ld a,0d8h
                out (c),a
            ei
        exx

        ld de,UnitSize
        ld a,(FirstIndex)
        ld hl,(FirstAddress)
        cp Sprite_Mono-Sprite_Color
        if nc
            add hl,de
            inc a
        endif
        add hl,de
        inc a
        cp Sprite_End-Sprite_Color
        if nc
            sub Sprite_End-Sprite_Color
            ld de,-UnitSize*(Sprite_End-Sprite_Color)
            add hl,de
        endif
        ld (FirstIndex),a
        ld (FirstAddress),hl
    pop bc | pop de | pop hl | pop af
ret
