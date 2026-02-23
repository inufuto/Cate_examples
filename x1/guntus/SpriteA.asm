include "Vram.inc"
include "VVram.inc"
; include "Chars.inc"

ext Sprites_
ext HideAllSprites_
ext SpritePatternSource_
ext SetRowFlags_, VVramOffset_
ext GVVram_
ext PollVSync_

SpriteCount equ 20
SpriteWidth equ 4
SpriteHeight equ 2
InvalidY equ 80h

Sprite_x equ 0
Sprite_y equ 1
Sprite_oldX equ 2
Sprite_oldY equ 3
Sprite_code equ 4
Sprite_type equ 5
Sprite_unitSize equ 6


; void EraseSprites();
cseg
EraseSprites_: public EraseSprites_
    push af | push hl | push de | push bc | push ix
        ld ix,Sprites_
        ld b,SpriteCount
        do
            push bc
                ld a,(ix+Sprite_oldY)
                cp InvalidY
                if nz
                    ; ld a,(ix+Sprite_oldX)
                    ; cp (ix+Sprite_x)
                    ; jr nz,do_erase
                    ; ld a,(ix+Sprite_oldY)
                    ; cp (ix+Sprite_y)
                    ; jr nz,do_erase
                    ; ld a,(ix+Sprite_code)
                    ; inc a
                    ; jr z,erase_next
                    ; do_erase:
                    ld a,(ix+Sprite_oldY)
                    srl a
                    if c
                        ld e,07h
                        ld c,3
                    else
                        ld e,03h
                        ld c,2
                    endif
                    call SetRowFlags_
                    exx
                        ld e,a
                    exx
                    ld e,a
                    ld a,(ix+Sprite_oldX)
                    call VVramOffset_
                    add hl,hl
                    ; ex de,hl
                    ;     ld hl,VVramBack_
                    ;     add hl,de
                    ; ex de,hl
                    push bc
                        ld bc,GVVram_
                        add hl,bc
                    pop bc
                    do
                        exx
                            ld a,e
                        exx
                        cp VVramHeight
                        jr nc,erase_next
                        ld b,SpriteWidth*2
                        do
                            ; ld a,(de) | inc de
                            ld (hl),0 | inc hl
                        dwnz
                        push bc
                            ld bc,GVVramWidth-SpriteWidth*2
                            add hl,bc
                            ex de,hl
                                add hl,bc
                            ex de,hl
                        pop bc
                        exx
                            inc e
                        exx
                        dec c
                    while nz | wend
                endif
                erase_next:
                ld bc,Sprite_unitSize
                add ix,bc
            pop bc
            call PollVSync_
        dwnz
    pop ix | pop bc | pop de | pop hl | pop af
ret


; ; void SetSpriteRowFlags();
; cseg
; SetSpriteRowFlags_: public SetSpriteRowFlags_
;     push af | push hl | push de | push bc | push ix
;         ld ix,Sprites_
;         ld b,SpriteCount
;         do
;             ld a,(ix+Sprite_oldY)
;             cp InvalidY
;             if nz
;                 ; ld a,(ix+Sprite_oldX)
;                 ; cp (ix+Sprite_x)
;                 ; jr nz,do_set
;                 ; ld a,(ix+Sprite_oldY)
;                 ; cp (ix+Sprite_y)
;                 ; jr nz,do_set
;                 ; ld a,(ix+Sprite_code)
;                 ; inc a
;                 ; jr z,set_next
;                 ; do_set:
;                 ld a,(ix+Sprite_oldY)
;                 srl a
;                 if c
;                     ld e,07h
;                 else
;                     ld e,03h
;                 endif
;                 call SetRowFlags_
;             endif
;             ; set_next:
;             ld de,Sprite_unitSize
;             add ix,de
;         dwnz
;     pop ix | pop bc | pop de | pop hl | pop af
; ret


; void DrawSprites();
cseg
DrawRow:
    ld b,SpriteWidth
    do
        ld (hl),d | inc hl
        inc d
        ld (hl),c | inc hl
    dwnz
    ld bc,GVVramWidth-SpriteWidth*2
    add hl,bc
ret
DrawSprites_: public DrawSprites_
    push af | push hl | push de | push bc | push ix
        ld ix,Sprites_
        ld b,SpriteCount
        do
            push bc
                ld a,(ix+Sprite_y)
                cp InvalidY
                if nz
                    ld e,a
                    and 1
                    ld d,a ; mod
                    srl e
                    ld a,(ix+Sprite_x)
                    call VVramOffset_
                    add hl,hl
                    ld bc,GVVram_
                    add hl,bc
                    ld a,(ix+Sprite_type)
                    or a
                    if z
                        ld a,e
                        cp VVramHeight
                        if c
                            ld a,d ; mod
                            or a
                            if z
                                ld a,e
                                push de
                                    ld e,1
                                    call SetRowFlags_
                                pop de
                                ld a,(ix+Sprite_code)
                                ld (hl),a
                                inc hl
                                ld (hl),0
                            else
                                ld a,e
                                push de
                                    ld e,3
                                    call SetRowFlags_
                                pop de
                                ld a,(ix+Sprite_code)
                                ld (hl),a
                                inc hl
                                ld (hl),1
                                ld bc,GVVramWidth-1
                                add hl,bc
                                ld (hl),a
                                inc hl
                                ld (hl),3
                            endif
                        endif
                    else
                        ld a,d ; mod
                        or a
                        if z
                            ld a,e
                            cp VVramHeight
                            if c
                                ld a,e
                                push de
                                    ld e,3
                                    call SetRowFlags_
                                pop de
                                ld d,(ix+Sprite_code)
                                ld c,0
                                call DrawRow
                                inc e
                                ld a,e
                                cp VVramHeight
                                if c
                                    ld c,0
                                    call DrawRow
                                endif
                            endif
                        else
                            ld a,e
                            cp VVramHeight
                            if c
                                ld a,e
                                push de
                                    ld e,7
                                    call SetRowFlags_
                                pop de
                                ld a,(ix+Sprite_type)
                                cp 3
                                if z
                                    ld a,(ix+Sprite_code)
                                    sub 4
                                    ld d,a
                                    ld c,2
                                    call DrawRow
                                else
                                    ld d,(ix+Sprite_code)
                                    ld c,1
                                    call DrawRow
                                endif
                                inc e
                                ld a,e
                                cp VVramHeight
                                if c
                                    ld d,(ix+Sprite_code)
                                    ld c,2
                                    call DrawRow
                                    inc e
                                    ld a,e
                                    cp VVramHeight
                                    if c
                                        ld c,2
                                        ld a,(ix+Sprite_type)
                                        cp 2
                                        if nz
                                            inc c
                                        endif
                                        call DrawRow
                                    endif
                                endif
                            endif
                        endif
                    endif
                endif
                ld a,(ix+Sprite_x) | ld (ix+Sprite_oldX),a
                ld a,(ix+Sprite_y) | ld (ix+Sprite_oldY),a
                ld bc,Sprite_unitSize
                add ix,bc
            pop bc
            call PollVSync_
        dwnz
    pop ix | pop bc | pop de | pop hl | pop af
ret
