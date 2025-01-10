include "Vram.inc"
include "Share.inc"

OffscreenPage equ $08

zseg
yCount:
    defb 0


cseg
SubMain: public SubMain
    lda #high yCount | tfr a,dp
    lda #$07 | sta $AFE2

    clr SubShareRam+Share_Command
loop:
    ldb $AFE0 | orb #$01 | stb $AFE0 ; ready
    lda SubShareRam+Share_Command
    beq loop
    ldb $AFE0 | andb #not $01 | stb $AFE0 ; busy
    
    cmpa #SubCommand_Clear
    if eq
        bsr ClearVram
        bra next
    endif
    
    cmpa #SubCommand_DefP
    if eq
        bsr DefinePattern
        bra next
    endif
   
    cmpa #SubCommand_PutP
    if eq
        bsr PutPattern
        bra next
    endif
    next:
    clr SubShareRam+Share_Command
bra loop

ClearVram:
    lda #$1f | sta $AFE1
    clr $AFE3

    ; lda #$aa
    ldx #0
    do
        clr ,x+
        ; sta ,x+
        cmpx #$4000
    while ne | wend
rts

DefinePattern:
    lda #$1f | sta $AFE1
    lda #OffscreenPage | sta $AFE3

    lda SubShareRam+Share_Char
    ldb#PatternSize | mul
    tfr d,y
    ldx #SubShareRam+Share_Pattern

    ldb #PatternSize
    do
        lda ,x+ | sta ,y+
        decb
    while ne | wend
rts


PutPattern:
    lda SubShareRam+Share_Char
    ldb#PatternSize | mul
    tfr d,x
    ldy SubShareRam+Share_Address

    ldb #$01
    do
        pshs b
            orb #$38 | andb #$3f | stb $AFE1
            lda #CharHeight | sta <yCount
            do
                ldb #OffscreenPage | stb $AFE3
                ldd ,x++
                clr $AFE3
                std ,y
                leay VramWidth,y
                dec <yCount
            while ne | wend
            leay -VramRowSize,y
        puls b
        lslb | andb #$07
    while ne | wend
rts
