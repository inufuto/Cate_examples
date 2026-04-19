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

; 6,7,8,9,0             --> Interprete as Sinclair Joystick Port 1
; SHIFT+5,6,7,8,SPACE   --> Interprete as Cursor Keys (for use in emulators)
; Q,A,O,P,SPACE         --> Interprete as Keyboard Keys
cseg
ScanKeys_: public ScanKeys_
    push de | push bc
        ld e,0
        
        ; Keyboard or Sinclair Port 1
        ld bc,0FEFEh
        in a,(c)
        bit 0,a ; Shift
        if z 
            ld bc,0F7FEh 
            in a,(c)
            bit 4,a ; 5
            if z
                set Keys_Bit_Left,e
            endif

            ld bc,0EFFEh
            in a,(c)
            bit 4,a ; 6
            if z
                set Keys_Bit_Down,e
            endif
            bit 3,a ; 7
            if z
                set Keys_Bit_Up,e
            endif
            bit 2,a ; 8
            if z
                set Keys_Bit_Right,e
            endif
        else
            ld bc,0FDFEh 
            in a,(c)
            bit 0,a ; A
            if z
                set Keys_Bit_Down,e
            endif
            
            ld bc,0FBFEh 
            in a,(c)
            bit 0,a ; Q
            if z
                set Keys_Bit_Up,e
            endif

            ld bc,0EFFEh
            in a,(c)
            bit 0,a ; 0
            if z 
                set Keys_Bit_Button0,e
            endif
            bit 1,a ; 9
            if z 
                set Keys_Bit_Up,e
            endif
            bit 2,a ; 8
            if z 
                set Keys_Bit_Down,e
            endif
            bit 3,a ; 7
            if z 
                set Keys_Bit_Right,e
            endif
            bit 4,a ; 6
            if z 
                set Keys_Bit_Left,e
            endif

            ld bc,0DFFEh
            in a,(c)
            bit 0,a ; P
            if z
                set Keys_Bit_Right,e
            endif
            bit 1,a ; O
            if z
                set Keys_Bit_Left,e
            endif
        endif
        ld bc,0BFFEh 
        in a,(c)
        bit 0,a ; Enter
        if z 
            set Keys_Bit_Button1,e
        endif        
        ld bc,07FFEh 
        in a,(c)
        bit 0,a ; Space
        if z 
            set Keys_Bit_Button0,e
        endif        
        ld a,e
    pop bc | pop de
ret
