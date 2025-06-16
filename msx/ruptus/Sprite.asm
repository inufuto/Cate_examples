include 'BIOS.inc'
include 'Vram.inc'

ext SpritePattern

BufferCount equ 32
BufferUnitSize equ 4
Offset_y equ 0
Offset_x equ 1
Offset_name equ 2
Offset_color equ 3

    dseg
Sprites_:   public Sprites_
Buffer:
    defs BufferUnitSize * BufferCount
FirstIndex:
    defs 1
FirstAddress:
    defs 2


    cseg
InitSprites_:
    public InitSprites_
	push	af
	push	hl
	push	de
	push	bc
        ld bc,0e201h
        call WRTVDP

        ld de, VRAM_SpriteGenerator
        ld hl, SpritePattern
        ld bc, 32*29
        call LDIRVM

        ld hl,Buffer
        ld de,BufferUnitSize
        ld b,BufferCount
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
        ld b,BufferCount
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
            ld d,BufferCount
            do
                ld b,BufferUnitSize
                do
                    ld e,(hl)
                    inc hl
                    out (c),e
                dwnz
                inc a
                cp BufferCount
                if nc
                    xor a
                    ld hl,Buffer
                endif
                dec d
            while nz | wend
        ei
    pop bc | pop de | pop hl | pop af
ret

RotateSprites_:
    public RotateSprites_
    push af | push hl
        ld a,(FirstIndex)
        ld hl,(FirstAddress)
        inc hl
        inc hl
        inc hl
        inc hl
        inc a
        cp BufferCount
        if nc
            xor a
            ld hl,Buffer
        endif
        ld (FirstIndex),a
        ld (FirstAddress),hl
    pop hl | pop af
ret