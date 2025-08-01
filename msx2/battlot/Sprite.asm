include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext ColorSpritePattern, MonoSpritePattern

; Top equ 8*0-1
HiddenY equ 192

Sprite_Color equ 0
Sprite_MyRobo equ 0
Sprite_EnemyRobo equ 2
Sprite_Bang equ 10
Sprite_Mono equ 20
Sprite_MyBullet equ 20
Sprite_EnemyBullet equ 22
Sprite_End equ 28

Offset_y equ 0
Offset_x equ 1
Offset_name equ 2
Offset_colors equ 3
UnitSize equ Offset_colors+16

dseg
Sprites: public Sprites
    defs UnitSize*Sprite_End
FirstIndex:
    defs 1
FirstAddress:
    defs 2

ShowSpriteC_@Param3: public ShowSpriteC_@Param3
ShowSpriteM_@Param3: public ShowSpriteM_@Param3
Param_pattern:
    defb 0
ShowSpriteM_@Param4: public ShowSpriteM_@Param4
Param_color:
    defb 0


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
ret


; void HideSprite(byte index);
HideAllSprites_: public HideAllSprites_
	push hl | push de | push bc
        ld hl,Sprites
        ld (FirstAddress),hl
        ld de,UnitSize
        ld b,Sprite_End
        do
            ld (hl),HiddenY
            add hl,de
        dwnz
        xor a
        ld (FirstIndex),a
    pop	bc | pop de | pop hl
    call UpdateSprites_
ret


ToSpritePtr: ; l->hl
    push de | push bc
        ld l,a
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
    pop bc | pop de
ret

; void ShowSpriteC(byte index, byte x, byte y, byte pattern);
cseg
ShowSpriteC_: public ShowSpriteC_
	push af | push hl | push de | push bc
        call ToSpritePtr
        ld d,c ; y
        ld a,(Param_pattern)
        exx
            ld e,a
        exx
        push hl
            ld b,a
            add a,a ;*2
            add a,b ;*3
            ld l,a | ld h,0
            add hl,hl ;*6
            add hl,hl ;*12
            add hl,hl ;*24
            add hl,hl ;*48
            ld bc,ColorSpritePattern | add hl,bc
            ld c,l | ld b,h
        pop hl
        exx
            ld d,00h
            sla e | sla e
        exx
        do
            ld (hl),d | inc hl ; y
            ld (hl),e | inc hl ; x
            exx
                ld a,e ; pattern
            exx
            ld (hl),a | inc hl
            ld a,c | add a,32 | ld c,a
            ld a,b | adc a,0 | ld b,a
            ld a,16
            do
                ex af,af'
                    ld a,(bc) | inc bc
                    exx
                        or d
                    exx
                    ld (hl),a | inc hl
                ex af,af'
                dec a
            while nz | wend
            exx
                inc e | inc e | inc e | inc e
                ld a,d
                xor 40h
                ld d,a
            exx
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void ShowSpriteM(byte index, byte x, byte y, byte pattern, byte color);
cseg
ShowSpriteM_: public ShowSpriteM_
	push af | push hl | push de | push bc
        call ToSpritePtr
        ld (hl),c ; y
        inc hl 
        ld a,e ; x
        ld (hl),a 
        inc hl
        ld a,(Param_pattern)
        add a,a | add a,a
        ld (hl),a ; pattern
        inc hl 
        ld a,(Param_color)
        ld b,16
        do
            ld (hl),a | inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret


HideSprite_: public HideSprite_
	push af | push hl | push de | push bc
        ld l,a  ; index
        call ToSpritePtr
        ld (hl),HiddenY
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
        ld d,Sprite_End
        do
            ld a,e
            cp Sprite_Mono
            if c
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
            cp Sprite_End
            if nc
                xor a
                ld hl,Sprites
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
        cp Sprite_Mono
        if c
            add hl,de
            inc a
        endif
        add hl,de
        inc a
        cp Sprite_End
        if nc
            xor a
            ld hl,Sprites
        endif
        ld (FirstIndex),a
        ld (FirstAddress),hl
    pop bc | pop de | pop hl | pop af
ret
