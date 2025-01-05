include "Vdp.inc"
include "Vram.inc"

ext LDIRVM, WRTVRM
ext SpritePattern

Top equ 8*2-1
Sprite_End equ 13
BufferUnitSize equ 3
InvaldY equ 192

    dseg
Sprites:   public Sprites
Buffer:
    defs BufferUnitSize * Sprite_End
FirstIndex:
    defs 1
FirstAddress:
    defs 2

cseg
InitSprites: public InitSprites
    ld hl,Buffer
    ld de,BufferUnitSize
    ld b,Sprite_End
    do 
        ld (hl),InvaldY
        add hl,de
    dwnz
    xor a
    ld (FirstIndex),a
    ld hl,Buffer
    ld (FirstAddress),hl
ret

cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push de
        push de
            ld l,(ix+2)  ; index
            ld h,0
            ld e,l
            ld d,h
            add hl,hl   ;*2
            add hl,de   ;*3
            ld de,Buffer
            add hl,de
        pop de
        di
            ld a,(ix+1) ; y
            add a,Top
            ld (hl),a
            inc hl 
            ld a,(ix+0) ; x
            ld (hl),a 
            inc hl 
            ld (hl),e ; pattern
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
            ld e,l
            ld d,h
            add hl,hl   ;*2
            add hl,de   ;*3
            ld de,Buffer
            add hl,de
            di
                ld (hl),InvaldY
            ei
    pop	de
	pop	hl
	pop	af
ret


HideAllSprites_: public HideAllSprites_
	push	hl
	push	bc
        ld hl,Buffer
        ld b,Sprite_End
        di
            do
                ld (hl),InvaldY
                inc hl
                inc hl
                inc hl
            dwnz
        ei
    pop	bc
	pop	hl
    call UpdateSprites_
ret


UpdateSprites_: public UpdateSprites_
    push af | push hl | push de | push bc
        ld de,VRAM_SpriteAttribute
        exx
            ld de,VRAM_SpriteAttribute+128
        exx
        di
            ld a,(FirstIndex)
            ld hl,(FirstAddress)
            ld b,Sprite_End
            do
                ex af,af'
                    ld a,(hl)
                    cp InvaldY
                    if c
                        ld c,a
                        ld a,e | out (VdpPort+1),a
                        ld a,d | or 40h | out (VdpPort+1),a
                        ld a,c
                        out (VdpPort),a
                        inc de
                        nop | nop | nop
                        out (VdpPort),a
                        inc de
                        inc hl
                        exx
                            ld a,e | out (VdpPort+1),a
                            ld a,d | or 40h | out (VdpPort+1),a
                            inc de | inc de | inc de | inc de
                        exx
                        ld c,(hl)
                        inc hl
                        ld a,(hl)
                        inc hl
                        ld i,a
                        ld a,c
                        out (VdpPort),a
                        nop | nop | nop
                        ld a,i
                                            _deb: public _deb
                        out (VdpPort),a
                        nop
                        ld a,c
                        add a,8
                        out (VdpPort),a
                        nop | nop | nop
                        ld a,i
                        add a,2
                        out (VdpPort),a
                    else
                        inc hl
                        inc hl
                        inc hl  
                    endif
                ex af,af'
                inc a
                cp Sprite_End
                if nc
                    xor a
                    ld hl,Buffer
                endif
            dwnz
            ld a,e | out (VdpPort+1),a
            ld a,d | or 40h | out (VdpPort+1),a
            ex af,af'
                ld a,0d0h
                out (VdpPort),a
            ex af,af'
        ei
        inc hl
        inc hl
        inc hl
        inc a
        cp Sprite_End
        if nc
            xor a
            ld hl,Buffer
        endif
        ld (FirstIndex),a
        ld (FirstAddress),hl
    pop bc | pop de | pop hl | pop af
ret
