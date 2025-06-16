include 'BIOS.inc'
include 'Vram.inc'
include 'Chars.inc'

ext SpritePattern
ext TopY_, dotOffset_

SpriteCount equ 15

sprite_y equ 0
sprite_x equ 1
sprite_pattern equ 2
sprite_color equ 3
sprite_unisSize equ 4

Movable_x equ 0
Movable_y equ 1
Movable_xd equ 2
Movable_yd equ 3
Movable_sprite equ 4


    dseg
Sprites_:   public Sprites_
Buffer:
    defs sprite_unisSize*SpriteCount
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
        ld bc,CharHeight*PatternCount
        call LDIRVM

        ld hl,Buffer
        ld de,sprite_unisSize
        ld b,SpriteCount
        do 
            ld (hl),192
            add hl,de
        dwnz
        xor a
        ld (FirstIndex),a
        ld hl,Buffer
        ld (FirstAddress),hl
    pop	bc
	pop	de
	pop	hl
	pop	af
ret

    cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de
        push de
            ld l,(ix+Movable_sprite)
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Buffer
            add hl,de
        pop de
        ld a,(TopY_)
        ld d,a
        ld a,(dotOffset_)
        ld b,a
        ; ld a,8
        ; sub b
        ; and 7
        ; ld b,a
        di
            ld a,(ix+Movable_y)
            sub d
            cp WindowHeight
            if c
                add a,2
                add a,a ;*2
                add a,a ;*4
                add a,a ;*8
                add a,(ix+Movable_yd)
                add a,b
                dec a
            else
                ld a,192
            endif
            ld (hl),a
            inc hl
            ld a,(ix+Movable_x)
            add a,a ;*2
            add a,a ;*4
            add a,a ;*8
            add a,(ix+Movable_xd)
            ld (hl),a
            inc hl 
            ld (hl),e ; pattern
            inc hl 
            ld (hl),c ; color
        ei
	pop	de | pop hl | pop af
ret


HideSprite_:
    public HideSprite_
	push	af
	push	hl
	push	de
            ld l,a  ; index
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Buffer
            add hl,de
            di
                ld (hl),192
            ei
    pop	de
	pop	hl
	pop	af
ret


HideAllSprites_:
    public HideAllSprites_
	push	hl
	push	bc
        ld hl,Buffer
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
                ld b,sprite_unisSize
                do
                    ld e,(hl)
                    inc hl
                    out (c),e
                dwnz
                inc a
                cp SpriteCount
                if nc
                    xor a
                    ld hl,Buffer
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
            ld hl,Buffer
        endif
        ld (FirstIndex),a
        ld (FirstAddress),hl
    pop bc | pop de | pop hl | pop af
ret
