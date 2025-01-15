include "neo6502.inc"

Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    pha
        lda #API_FN_READ_CONTROLLER | sta API_FUNCTION
        lda #API_GROUP_CONTROLLER | sta API_COMMAND
        jsr WaitMessage
        ldy API_PARAMETERS+0
    pla
rts