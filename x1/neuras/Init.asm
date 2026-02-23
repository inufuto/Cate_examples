include 'X1.inc'

extrn InitCG, InitSound_

Init_: public  Init_
    ld bc,CRTC
    ld a,1
    out (c),a
    ld bc,CRTC+1
    ld a,VramWidth
    out (c),a

    call InitCG
    call InitSound_
ret

Fin_:
    public Fin_
ret
