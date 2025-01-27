Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

PortA equ $f8
PortC equ $fa
KeyPort equ $7dfc

dseg
HexKeyAvailable:
    defb 0

cseg
InitKeys_: public InitKeys_
    push psw
        xra a | sta HexKeyAvailable
    pop psw
ret


cseg
KeyTable:
    defb ' ',Keys_Button0
    defb 'Z',Keys_Button1
    defb 'I',Keys_Up
    defb 'J',Keys_Left
    defb 'K',Keys_Right
    defb 'M',Keys_Down
ScanKeys_: public ScanKeys_
    push h | push d
        lda HexKeyAvailable
        ora a
        if z
            lda KeyPort
            lxi h,KeyTable
            mvi e,6
            do
                cmp m
                if z
                    inx h
                    mov a,m
                    jmp ScanKeys_exit
                endif
                inx h | inx h
                dcr e
            while nz | wend
        endif
        mvi e,0
            mvi a,$60 | out PortC
            in PortA
            mov d,a
            ani $01 ; 0
            if z
                mov a,e | ori Keys_Button0 | mov e,a
            endif
            mov a,d
            ani $02 ; 1
            if z
                mov a,e | ori Keys_Left | mov e,a
            endif
            mov a,d
            ani $04 ; 2
            if z
                mov a,e | ori Keys_Down | mov e,a
            endif
            mov a,d
            ani $08 ; 3
            if z
                mov a,e | ori Keys_Right | mov e,a
            endif
            mov a,d
            ani $10 ; 4
            if z
                mov a,e | ori Keys_Button1 | mov e,a
            endif
            mov a,d
            ani $40 ; 6
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
        mov a,e
        ora a
        if nz
            sta HexKeyAvailable
        endif
        ScanKeys_exit:
    pop d | pop h 
ret
