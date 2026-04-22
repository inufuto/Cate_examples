include "Vdp.inc"
include "Vram.inc"

ext Handler

dseg
NmiEnabled:  public NmiEnabled
    defb 0


cseg
DisableNmi: public DisableNmi
    push af
        xor a
        ld (NmiEnabled),a
    pop af
ret

EnableNmi: public EnableNmi
    push af
        ld a,0ffh
        ld (NmiEnabled),a
        ; ld a,(VdpAddress+1)
    pop af
    call Handler
ret


SetVdpAddressDE: public SetVdpAddressDE
    ld a,e | out (VdpPort+1),a
    rst 10h
    ld a,d | and 3fh | or 40h | out (VdpPort+1),a
    rst 10h
ret


SetVdpAddressHL: public SetVdpAddressHL
    ld a,l | out (VdpPort+1),a
    rst 10h
    ld a,h | and 3fh | or 40h | out (VdpPort+1),a
    rst 10h
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
    ; di
    call DisableNmi
        push af
            call SetVdpAddressHL
        pop af
        out (VdpPort),a
    ; ei
    call EnableNmi
ret


RDVRM: public RDVRM
    ; di
    call DisableNmi
        ld a,l | out (VdpPort+1),a
        rst 10h
        ld a,h | and 3fh | out (VdpPort+1),a
        rst 10h
        ; push af | pop af
        in a,(VdpPort)
    ; ei
    call EnableNmi
ret


LDIRVM: public LDIRVM
    ; di
    call DisableNmi
        call SetVdpAddressDE
        do
            ; rst 10h
            ld a,(hl) | inc hl
            out (VdpPort),a
            ; rst 10h
            dec bc
            ld a,c
            or b
        while nz | wend
    ; ei
    call EnableNmi
ret

FILVRM: public FILVRM
    push de
        ld e,a
        ; di
        call DisableNmi
            call SetVdpAddressHL
            do
                ld a,e | out (VdpPort),a
                dec bc
                ld a,c
                or b
            while nz | wend
        ; ei
        call EnableNmi
    pop de
ret

WRTVDP: public WRTVDP
    push af
        call DisableNmi
            ld a,b
            out (VdpPort+1),a
            ld a,c
            or 80h
            out (VdpPort+1),a
        call EnableNmi
    pop af
ret
