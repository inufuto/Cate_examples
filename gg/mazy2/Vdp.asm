include 'Vdp.inc'
include 'Vram.inc'

ext Handler

; SetVdpAddressDE: public SetVdpAddressDE
;     ld a,e | out (VdpPort+1),a
;     rst 30h
;     ld a,d | and 3fh | or 40h | out (VdpPort+1),a
;     rst 30h
; ret


SetVdpAddressHL: public SetVdpAddressHL
    ld a,l | out (VdpPort+1),a
    rst 30h
    ld a,h | and 3fh | or 40h | out (VdpPort+1),a
    rst 30h
ret


VdpValues:
    defb 16h,0e2h
    defb 0ffh,0ffh,0ffh,0ffh,0fbh,00h
    defb 00h,00h,0ffh
ColorValues:
	defb 00h,00h,05h,0fh,0fh,00h,0afh,0fh
	defb 0f0h,00h,0a0h,0fh,0ffh,00h,0ffh,0fh
	defb 00h,00h,55h,05h,5ah,00h,5fh,05h
	defb 50h,00h,50h,0ah,0afh,00h,0aah,0ah
InitVdp: public InitVdp
    di
        ld hl,VdpValues
        ld c,0
        ld b,11
        do
            ld a,(hl) | out (VdpPort+1),a
            inc hl
            ld a,c | or 80h | out (VdpPort+1),a
            inc c
        dwnz

        xor a | out (VdpPort+1),a
        ld a,0c0h | out (VdpPort+1),a
        ld c,2
        do
            ld hl,ColorValues
            ld b,16*2
            do
                ld a,(hl) | inc hl
                out (VdpPort),a
            dwnz
            dec c
        while nz | wend
    ei
ret


WRTVRM: public WRTVRM
    di
        push af
            ld a,l | out (VdpPort+1),a
            ld a,h | or 40h | out (VdpPort+1),a
        pop af
        ; push af
        ;     call SetVdpAddressHL
        ; pop af
        out (VdpPort),a
    ei
ret


RDVRM: public RDVRM
    di
        ld a,l | out (VdpPort+1),a
        ld a,h | and 3fh | out (VdpPort+1),a
        push af | pop af
        ; push af
        ;     ld a,l | out (VdpPort+1),a
        ;     rst 30h
        ;     ld a,h | and 3fh | out (VdpPort+1),a
        ;     rst 30h
        ; pop af        
        in a,(VdpPort)
    ei
ret


; LDIRVM: public LDIRVM
;     di
;         ld a,e | out (VdpPort+1),a
;         ld a,d | or 40h | out (VdpPort+1),a
;         ; call SetVdpAddressDE
;         do
;             ld a,(hl) | inc hl
;             out (VdpPort),a
;             dec bc
;             ld a,c
;             or b
;         while nz | wend
;     ei
; ret

FILVRM: public FILVRM
    push de
        ld e,a
        di
            ld a,l | out (VdpPort+1),a
            ld a,h | or 40h | out (VdpPort+1),a
            ; call SetVdpAddressHL
            do
                ld a,e | out (VdpPort),a
                dec bc
                ld a,c
                or b
            while nz | wend
        ei
    pop de
ret

WRTVDP: public WRTVDP
    push af
        di
            ld a,b
            out (VdpPort+1),a
            ld a,c
            or 80h
            out (VdpPort+1),a
        ei
    pop af
ret
