include 'Vram.inc'

extrn InitVram_, InitSound_

CRTC equ 1800h

Init_: public  Init_
    ld bc,CRTC
    ld a,1
    out (c),a
    inc bc
    ld a,VramWidth
    out (c),a

    ld a,0aah
    ld bc,1000h
    out (c),a
    ld a,0cch
    inc b
    out (c),a
    ld a,0f0h
    inc b
    out (c),a
    ld a,0feh
    inc b
    out (c),a


    call InitVram_
    call InitSound_
ret

Fin_:
    public Fin_
ret
