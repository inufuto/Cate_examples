include "kh1000.inc"
include 'Vram.inc'

ext WRTVRM, LDIRVM, FILVRM, SetVdpAddressDE, SetVdpAddressHL
ext SpritePattern

Pattern_Count equ 23
SpriteCount equ 21
BufferUnitSize equ 4
Offset_y equ 0
Offset_x equ 1
Offset_name equ 2
Offset_color equ 3

    dseg
Sprites_:   public Sprites_
Buffer:
    defs BufferUnitSize * SpriteCount
FirstIndex:
    defs 1
FirstAddress:
    defs 2

cseg
InitSprites: public InitSprites
	push	af
	push	hl
	push	de
	push	bc
        ld hl,SpritePattern
        ld de,Vram_SpriteGenerator
        ld bc,SpriteSize*Pattern_Count
        call LDIRVM

        ld hl,Buffer
        ld de,BufferUnitSize
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

    dseg
    ShowSprite_@Param3: public	ShowSprite_@Param3
ShowSprite_pattern:	defs 1
    ShowSprite_@Param4: public	ShowSprite_@Param4
ShowSprite_color:	defs 1
    cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de
        push de
            ld l,a  ; index
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Buffer
            add hl,de
        pop de
        ld a,c
        cp 192
        ld (hl),c   ; y
        inc hl 
        ld (hl),e   ; x
        inc hl 
        ld a,(ShowSprite_pattern)
        add a,a
        add a,a
        ld (hl),a
        inc hl 
        ld a,(ShowSprite_color)
        ld (hl),a
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
    call UpdateSprites_
ret


UpdateSprites_:
    public UpdateSprites_
    push af | push hl | push de | push bc
        ld hl,VRAM_SpriteAttribute or 4000h
        di
            call SetVdpAddressHL
            
            ld a,(FirstIndex)
            ld hl,(FirstAddress)
            ld d,SpriteCount
            do
                ld b,BufferUnitSize
                do
                    ld e,(hl)
                    inc hl
                    ex af,af'
                        ld a,e
                        ld (VdpAddress),a
                    ex af,af'
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
