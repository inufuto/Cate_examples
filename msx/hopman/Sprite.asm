include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext SpritePattern
ext LeftX_,DotOffset_

Top equ 8*2-1

SpriteCount equ 13

UnitSize equ 4
Offset_y equ 0
Offset_x equ 1
Offset_name equ 2
Offset_color equ 3

    dseg
Sprites_:   public Sprites_
    defs UnitSize * SpriteCount
FirstIndex:
    defs 1
FirstAddress:
    defs 2

; void InitSprites();
cseg
InitSprites_: public InitSprites_
	push	af
	push	hl
	push	de
	push	bc
        ld bc,0e201h
        call WRTVDP

        ld hl,SpritePattern
        ld de,Vram_SpriteGenerator
        ld bc,CharHeight*4*Pattern_End
        call LDIRVM

        ld hl,Sprites_
        ld de,UnitSize
        ld b,SpriteCount
        do 
            ld (hl),192
            add hl,de
        dwnz
        xor a
        ld (FirstIndex),a
        ld hl,Sprites_
        ld (FirstAddress),hl
    pop	bc
	pop	de
	pop	hl
	pop	af
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de
        push de
            ld l,(ix+3)  ; index
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Sprites_
            add hl,de
        pop de
        ld a,(LeftX_) | ld d,a
        ld a,(DotOffset_) | ld b,a
        
        ld a,(ix+1) ; y
        add a,Top
        ld (hl),a
        ld a,(ix+0) ; x
        sub d
        ; cp -2
        ; if nc
        ;     set 7,c
        ;     add a,32
        ; else
            cp VramWidth
            if nc
                ld (hl),192
            endif
        ; endif
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        sub b
        add a,(ix+2) ; xd
        inc hl 
        ld (hl),a 
        inc hl
        sla e | sla e
        ld (hl),e ; pattern
        inc hl 
        ld (hl),c ; color
	pop	de | pop hl | pop af
ret


; void HideSprite(byte index);
HideSprite_:
    public HideSprite_
	push	af
	push	hl
	push	de
        ld l,a  ; index
        ld h,0
        add hl,hl   ;*2
        add hl,hl   ;*4
        ld de,Sprites_
        add hl,de
        di
            ld (hl),192
        ei
    pop	de
	pop	hl
	pop	af
ret


; void HideAllSprites();
HideAllSprites_:
    public HideAllSprites_
	push	hl
	push	bc
        ld hl,Sprites_
        ld b,SpriteCount
        di
            do
                ld (hl),192
                inc hl
                inc hl
                inc hl
                inc hl
            dwnz
        ei
    pop	bc
	pop	hl
    call UpdateSprites_
ret


; void UpdateSprites();
UpdateSprites_:
    public UpdateSprites_
    push af | push hl | push de | push bc
        ld a,(VdpOutPort)
        ld c,a
        ld hl,VRAM_SpriteAttribute or 4000h
        di
            inc c
            out (c),l
            out (c),h
            dec c
            
            ld a,(FirstIndex)
            ld hl,(FirstAddress)
            ld d,SpriteCount
            do
                ld b,UnitSize
                do
                    ld e,(hl)
                    inc hl
                    out (c),e
                dwnz
                inc a
                cp SpriteCount
                if nc
                    xor a
                    ld hl,Sprites_
                endif
                dec d
            while nz | wend
        ei
        inc hl
        inc hl
        inc hl
        inc hl
        inc a
        cp SpriteCount
        if nc
            xor a
            ld hl,Sprites_
        endif
        ld (FirstIndex),a
        ld (FirstAddress),hl
    pop bc | pop de | pop hl | pop af
ret
