include 'BIOS.inc'

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

Keys_Bit_Left equ 0
Keys_Bit_Right equ 1
Keys_Bit_Up equ 2
Keys_Bit_Down equ 3
Keys_Bit_Button0 equ 4
Keys_Bit_Button1 equ 5

    cseg
KeyBits: 
    defb Keys_Up, Keys_Up or Keys_Right, Keys_Right, Keys_Right or Keys_Down
    defb Keys_Down, Keys_Down or Keys_Left, Keys_Left, Keys_Left or Keys_Up

ScanKeys_:
    public ScanKeys_
    push hl
    push de
    push bc
        ld e,0
        ld bc,200h
        do
            push bc | push de
                ld a,c
                call GTSTCK    
            pop de | pop bc
            or a
            if nz
                dec a
                exx
                    ld e,a
                    ld d,0
                    ld hl,KeyBits
                    add hl,de
                    ld a,(hl)
                exx
                or e
                ld e,a
            endif
            ld a,c
            push bc | push de
                call GTTRIG
            pop de | pop bc
            or a
            if nz
                set Keys_Bit_Button0,e
            endif
            inc c
        dwnz
        
        ld a,6
        call SNSMAT
        and 4   ;GRPH key
        if z 
            set Keys_Bit_Button1,e
        endif
        ld a,3
        push de
            call GTTRIG
        pop de
        or a
        if nz
            set Keys_Bit_Button1,e
        endif
        
        ld a,e
    pop bc
    pop de
    pop hl
ret 

; ScanStop_:
;     public ScanStop_
;     ld a,6
;     call SNSMAT
;     and 2   ;CTRL key
;     if z
;         ld a,3
;         call SNSMAT
;         and 1   ;C key
;         if z
;             ld a,1
;             ret
;         endif
;     endif
;     xor a
; ret