include 'BIOS.inc'

VRAM_SpriteAttribute equ 1b00h
VRAM_SpriteGenerator equ 3800h

extrn SpritePatterns, SpriteColors

BufferCount equ 6
BufferUnitSize equ 4
Offset_y equ 0
Offset_x equ 1
Offset_name equ 2
Offset_color equ 3

    dseg
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
        ld hl, SpritePatterns
        ld bc, 17*32
        call LDIRVM

        ld hl,Buffer+Offset_color
        ld de,BufferUnitSize
        ld b,BufferCount
        do 
            ld (hl),80h
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
    ShowSprite_@Param3:
	public	ShowSprite_@Param3
ShowSprite_.pattern_:	defs 1
    cseg
ShowSprite_:
    public ShowSprite_
	push af
	push hl
	push de
    push bc
        push de
            ld l,a  ; index
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            ld de,Buffer
            add hl,de
            push hl
                ld a,(ShowSprite_@Param3)   ; pattern
                ld b,a
                ld e,a
                ld d,0
                ld hl,SpriteColors
                add hl,de
                ld a,(hl)   ; color
            pop hl
        pop de
        ld d,a  ; color
        ld a,c  ; y
        add a,16
        ld (hl),a
        inc hl 
        ld (hl),e   ; x
        inc hl 
        ld a,b   ; pattern
        add a,a
        add a,a
        ld (hl),a
        inc hl 
        ld (hl),d   ; color
    pop bc
	pop	de
	pop	hl
	pop	af
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
            ld de,Buffer+Offset_color
            add hl,de
            ld (hl),80h
    pop	de
	pop	hl
	pop	af
ret


HideAllSprites_:
    public HideAllSprites_
	push	hl
	push	bc
        ld hl,Buffer+Offset_color
        ld b,BufferCount
        do
            ld (hl),80h
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