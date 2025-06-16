include 'BIOS.inc'
include 'Vram.inc'

ext SpritePattern

Top equ 8*2-1

SpriteCount equ 25

UnitSize equ 4
Offset_y equ 0
Offset_x equ 1
Offset_pattern equ 2
Offset_color equ 3

    dseg
Sprites_:   public Sprites_
Buffer:
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
        ld hl,Buffer
        ld de,UnitSize
        ld b,SpriteCount
        do 
            ld (hl),192
            add hl,de
        dwnz
        xor a
        ld (FirstIndex),a
        ld hl,Buffer
        ld (FirstAddress),hl

        ld hl,Vram_SpriteAttribute
        ld bc,4*32
        ld a,0d0h
        call FILVRM    
    pop	bc
	pop	de
	pop	hl
	pop	af
ret

    cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de
        push de
            ld l,(ix+2)  ; index
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Buffer
            add hl,de
        pop de
        ld a,(ix+1) ; y
        add a,Top
        ld (hl),a
        inc hl 
        ld a,(ix+0) ; x
        ld (hl),a 
        inc hl 
        ld (hl),e ; pattern
        inc hl 
        ld (hl),c ; color
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
            ld (hl),192
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
        do
            ld (hl),192
            inc hl
            inc hl
            inc hl
            inc hl
        dwnz
    pop	bc
	pop	hl
ret


UpdateSprites_: public UpdateSprites_
    push af | push hl | push de | push bc
        ld a,(VdpOutPort)
        ld c,a
        ld hl,VRAM_SpriteAttribute or 4000h
        inc c
        di
            out (c),l
            out (c),h
        ei
        dec c
        ld a,(FirstIndex)
        ld hl,(FirstAddress)
        ld d,SpriteCount
        do
            ex af,af'
                ld a,(hl) | inc hl
                cp 192
                if c
                    out (c),a
                    ld b,UnitSize-1
                    do
                        ld e,(hl) | inc hl
                        out (c),e
                    dwnz
                else
                    inc hl | inc hl | inc hl
                endif
            ex af,af'
            inc a
            cp SpriteCount
            if nc
                xor a
                ld hl,Buffer
            endif
            dec d
        while nz | wend
        ld e,0d0h
        out (c),e
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
