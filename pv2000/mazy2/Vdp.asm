include 'Vdp.inc'
include 'Vram.inc'

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
    pop af
    call Handler
ret


SetVdpAddressDE: public SetVdpAddressDE
    ld a,e | ld (VdpAddress+1),a
    push af | pop af
    ld a,d | and 3fh | or 40h | ld (VdpAddress+1),a
    push af | pop af
ret


SetVdpAddressHL: public SetVdpAddressHL
    ld a,l | ld (VdpAddress+1),a
    push af | pop af
    ld a,h | and 3fh | or 40h | ld (VdpAddress+1),a
    push af | pop af
ret


VdpValues:
    defb 02h,0e2h
    defb 06h,0ffh,03h,36h,07h,00h
InitVdp: public InitVdp
    ld hl,VdpValues
    ld c,0
    ld b,8
    do
        ld a,(hl) | ld (VdpAddress+1),a
        inc hl
        ld a,c | or 80h | ld (VdpAddress+1),a
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
        ld (VdpAddress),a
    ; ei
    call EnableNmi
ret


RDVRM: public RDVRM
    ; di
    call DisableNmi
        ld a,l | ld (VdpAddress+1),a
        push af | pop af
        ld a,h | and 3fh | ld (VdpAddress+1),a
        push af | pop af
        ld a,(VdpAddress)
    ; ei
    call EnableNmi
ret


LDIRVM: public LDIRVM
    ; di
    call DisableNmi
        call SetVdpAddressDE
        do
            ; push af | pop af
            ld a,(hl) | inc hl
            ld (VdpAddress),a
            ; push af | pop af
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
                ld a,e | ld (VdpAddress),a
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
            ld (VdpAddress+1),a
            ld a,c
            or 80h
            ld (VdpAddress+1),a
        call EnableNmi
    pop af
ret
