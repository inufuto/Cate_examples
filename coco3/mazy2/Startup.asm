INIT0 equ $FF90
INIT1 equ $FF91
VMODE equ $FF98
VRES equ $FF99

ext InitVram, InitSound, Main_

dseg
IrqJmp:
    defs 3
TimerCount: 
    defb 0 public TimerCount

zseg
Direct: public Direct

cseg
    lda INIT0
    anda #not $80
    ora #$40
    sta INIT0

    lda INIT1
    anda #$fe
    sta INIT1

    ; lda VMODE
    ; anda #$0f
    ; ora #$80
    lda #$80
    sta VMODE

    lda #$1a
    sta VRES

    ldd #$c000
    sta $FF9D
    stb $FF9D+1

    ldx #$FFA8
    lda #$38
    do
        sta ,x+
        inca
        cmpa #$3c
    while ne | wend
    lda #$30
    do
        sta ,x+
        inca
        cmpa #$33
    while ne | wend

    pshs cc | orcc #$50
        lda #$7e
        sta IrqJmp
        ldx $10d
        stx IrqJmp+1
        ldx #Handler
        stx $10d
        clr TimerCount
    puls cc

    ldx #PaletteValues
    ldy #$FFB0
    ldb #16
    do
        lda ,x+
        sta ,y+
        decb
    while ne | wend

    ; Sound
    lda $FF23
    ora #$08
    sta $FF23

    jsr InitVram
    jsr InitSound
jmp Main_

cseg
PaletteValues:
	defb	$00, $0d, $15, $1b, $0f, $1d, $25, $20
	defb	$10, $1c, $17, $29, $31, $3d, $24, $3f

Handler:
    inc TimerCount
jmp IrqJmp


dseg
WaitTimer_param:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    sta WaitTimer_param
        do
            lda TimerCount
            cmpa WaitTimer_param
        while cs | wend
    lda WaitTimer_param
    orcc #$50
        clr TimerCount
    andcc #not $50
rts
