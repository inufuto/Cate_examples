include "Vram.inc"
include "Chars.inc"

ext FortDotOffset_, FortCharOffset_
ext FortPattern7
ext NextPage_

; void UpdateFortChars();
cseg
PatternTable:
    defw FortPattern7+CharHeight*TPlaneCount*6*7*0
    defw FortPattern7+CharHeight*TPlaneCount*6*7*1
    defw FortPattern7+CharHeight*TPlaneCount*6*7*2
    defw FortPattern7+CharHeight*TPlaneCount*6*7*3
UpdateFortChars_: public UpdateFortChars_
    push af | push hl | push de | push bc
        ld a,(FortDotOffset_)
        add a,a
        add a,low(PatternTable) | ld l,a
        ld a,high(PatternTable) | adc a,0 | ld h,a
        ld e,(hl) | inc hl | ld d,(hl)

        ld a,(FortCharOffset_)
        or a
        if z
            ld hl,PCGAddress+800h+CharHeight*Char_Fort0
        else
            ld hl,PCGAddress+800h+CharHeight*Char_Fort1
        endif

        exx
            ld e,Char_Fort1-Char_Fort0
        exx
        do
            ld c,TPlaneCount
            do
                ld b,CharHeight
                do
                    ld a,(de) | inc de
                    ld (hl),a | inc hl
                dwnz
                ld a,l | add a,low(800h-CharHeight) | ld l,a
                ld a,h | adc a,high(800h-CharHeight) | ld h,a
                dec c
            while nz | wend
            ld a,l | sub low(1800h-CharHeight) | ld l,a
            ld a,h | sbc a,high(1800h-CharHeight) | ld h,a
            exx
                dec e
            exx
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawFort(byte x, byte y);
cseg
DrawFort_: public DrawFort_
    push af | push hl | push de | push bc
                                            _deb: public _deb
        ld d,a ; x
        ld a,e ; y
        exx
            ld c,a ; yPos
        exx
        add a,16+2
        ld l,a
        add a,a ;*2
        add a,a ;*4
        add a,l ;*5
        ld l,a | ld h,0
        add hl,hl ;*10
        add hl,hl ;*20
        add hl,hl ;*40
        ld e,d | ld d,0 ;x
        add hl,de
        ex de,hl
            call NextPage_
        ex de,hl
        add hl,de
        ld de,VramWidth*(-(16+2)) | add hl,de

        ld a,(FortCharOffset_)
        add a,Char_Fort
        ld e,a ; char
        exx
            ld a,c ; yPos
        exx
        ld d,a ; yPos
        ld c,7
        do
            ld a,d
            cp VramHeight
            if c
                ld b,6
                do
                    ld (hl),e | inc hl
                    inc e
                dwnz
                ld a,l | add a,VramWidth-6 | ld l,a
                ld a,h | adc a,0 | ld h,a
            else
                inc e | inc e | inc e | inc e | inc e | inc e
                ld a,l | add a,VramWidth | ld l,a
                ld a,h | adc a,0 | ld h,a
            endif
            inc d
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
