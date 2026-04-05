include "VVram.inc"
include "Chars.inc"

ext PanelMap_
ext VVram_

; ptr<byte> MapPtr(byte column, byte row);
cseg
MapPtr_: public MapPtr_
    push af | push bc
        ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        ld l,a | ld h,0
        ld b,0
        add hl,bc
        ld bc,PanelMap_
        add hl,bc
    pop bc | pop af
ret


ext MovingPanel_, pMoving_

ColumnCount equ 8
RowCount equ 6
PanelSize equ 4

Panel_Left equ 01h
Panel_Right equ 02h
Panel_Top equ 04h
Panel_Bottom equ 08h
Panel_Exist equ 10h
Panel_Star equ 40h

; void MapToVVram();
MapToVVram_: public MapToVVram_
    push af | push hl | push de | push bc | push ix
        ld ix,PanelMap_
        ld hl,VVram_
        ld c,0 ; row
        do
            ld b,0 ; column
            do
                ld a,(ix)
                or a
                if nz
                    ld e,a
                    ld d,0
                    ld a,b | or a
                    if nz
                        ld a,(ix-1) | or a
                        if z
                            ld a,d | or Panel_Left | ld d,a
                        endif
                    endif
                    ld a,b | cp ColumnCount-1
                    if nz
                        ld a,(ix+1) | or a
                        if z
                            ld a,d | or Panel_Right | ld d,a
                        endif
                    endif
                    ld a,c | or a
                    if nz
                        ld a,(ix-ColumnCount) | or a
                        if z
                            ld a,d | or Panel_Top | ld d,a
                        endif
                    endif
                    ld a,c | cp RowCount-1
                    if nz
                        ld a,(ix+ColumnCount) | or a
                        if z
                            ld a,d | or Panel_Bottom | ld d,a
                        endif
                    endif
                    call DrawPanel
                else
                    push bc
                        ld de,VVramWidth-PanelSize
                        ld c,PanelSize
                        do
                            ld b,PanelSize
                            do
                                ld (hl),Char_Space | inc hl
                            dwnz
                            add hl,de
                            dec c
                        while nz | wend
                        ld de,PanelSize-VVramWidth*PanelSize
                        add hl,de
                    pop bc
                endif
                inc ix
                inc b
                ld a,b
                cp ColumnCount
            while c | wend
            ld de,VVramWidth*PanelSize-PanelSize*ColumnCount
            add hl,de

            inc c
            ld a,c
            cp RowCount
        while c | wend

        ld a,(MovingPanel_)
        or a
        if nz
            ld e,a
            ld d,0
            ld hl,(pMoving_)
            call DrawPanel
        endif
    pop ix | pop bc | pop de | pop hl | pop af
ret
DrawPanel:; (hl, e, d)
                                    public DrawPanel
    push bc
        ld (hl),Char_Panel+0 | inc hl
        ld a,e | and Panel_Top
        if nz
            ld bc,0+(Char_Panel+4)or((Char_Panel+4)shl 8)
        else
            ld a,d | and Panel_Top
            if nz
                ld bc,0+(Char_Arrow+4)or((Char_Arrow+5)shl 8)
            else
                ld bc,0+(Char_Space)or((Char_Space)shl 8)
            endif
        endif
        ld (hl),c | inc hl
        ld (hl),b | inc hl
        ld (hl),Char_Panel+1
        ld bc,1+VVramWidth-PanelSize | add hl,bc

        ld a,e | and Panel_Left
        if nz
            ld bc,0+(Char_Panel+4)or((Char_Panel+4)shl 8)
        else
            ld a,d | and Panel_Left
            if nz
                ld bc,0+(Char_Arrow+0)or((Char_Arrow+2)shl 8)
            else
                ld bc,0+(Char_Space)or((Char_Space)shl 8)
            endif
        endif
        push de
            ld (hl),c
            ld de,VVramWidth | add hl,de
            ld (hl),b
            ld de,1-VVramWidth | add hl,de
        pop de
        ld a,e | and Panel_Star
        if nz
            ld a,Char_Star
            push de
                ld de,VVramWidth-2
                ld c,2
                do
                    ld b,2
                    do
                        ld (hl),a | inc hl
                        inc a
                    dwnz
                    add hl,de
                    dec c
                while nz | wend
                ld de,2-VVramWidth*2 | add hl,de
            pop de
        else
            ld a,Char_Space
            push de
                ld de,VVramWidth-2
                ld c,2
                do
                    ld b,2
                    do
                        ld (hl),a | inc hl
                    dwnz
                    add hl,de
                    dec c
                while nz | wend
                ld de,2-VVramWidth*2 | add hl,de
            pop de
        endif
        ld a,e | and Panel_Right
        if nz
            ld bc,0+(Char_Panel+4)or((Char_Panel+4)shl 8)
        else
            ld a,d | and Panel_Right
            if nz
                ld bc,0+(Char_Arrow+1)or((Char_Arrow+3)shl 8)
            else
                ld bc,0+(Char_Space)or((Char_Space)shl 8)
            endif
        endif
        push de
            ld (hl),c
            ld de,VVramWidth | add hl,de
            ld (hl),b
            ld de,VVramWidth-3 | add hl,de
        pop de

        ld (hl),Char_Panel+2 | inc hl
        ld a,e | and Panel_Bottom
        if nz
            ld bc,0+(Char_Panel+4)or((Char_Panel+4)shl 8)
        else
            ld a,d | and Panel_Bottom
            if nz
                ld bc,0+(Char_Arrow+6)or((Char_Arrow+7)shl 8)
            else
                ld bc,0+(Char_Space)or((Char_Space)shl 8)
            endif
        endif
        ld (hl),c | inc hl
        ld (hl),b | inc hl
        ld (hl),Char_Panel+3
        ld bc,1-VVramWidth*(PanelSize-1) | add hl,bc
    pop bc
ret