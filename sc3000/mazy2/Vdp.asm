include 'Vdp.inc'
include 'Vram.inc'

ext Handler

SetVdpAddressDE: public SetVdpAddressDE
    ld a,e | out (VdpPort+1),a
    rst 30h
    ld a,d | and 3fh | or 40h | out (VdpPort+1),a
    rst 30h
ret


SetVdpAddressHL: public SetVdpAddressHL
    ld a,l | out (VdpPort+1),a
    rst 30h
    ld a,h | and 3fh | or 40h | out (VdpPort+1),a
    rst 30h
ret


VdpValues:
    defb 02h,0e2h
    defb 06h,0ffh,03h,36h,07h,00h
InitVdp: public InitVdp
    ld hl,VdpValues
    ld c,0
    ld b,8
    do
        ld a,(hl) | out (VdpPort+1),a
        inc hl
        ld a,c | or 80h | out (VdpPort+1),a
        inc c
    dwnz

    ld hl,Vram_SpriteAttribute
    ld bc,4*32
    ld a,0c0h
    call FILVRM
ret


WRTVRM: public WRTVRM
    di
        push af
            call SetVdpAddressHL
        pop af
        out (VdpPort),a
    ei
ret


RDVRM: public RDVRM
    di
        push af
            ld a,l | out (VdpPort+1),a
            rst 30h
            ld a,h | and 3fh | out (VdpPort+1),a
            rst 30h
        pop af        
        in a,(VdpPort)
    ei
ret


LDIRVM: public LDIRVM
    di
        call SetVdpAddressDE
        do
            ld a,(hl) | inc hl
            out (VdpPort),a
            dec bc
            ld a,c
            or b
        while nz | wend
    ei
ret

FILVRM: public FILVRM
    push de
        ld e,a
        di
            call SetVdpAddressHL
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
