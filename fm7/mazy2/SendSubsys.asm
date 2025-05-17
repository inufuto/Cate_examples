include "BIOS.inc"
include "SubBin.inc"
include "Vram.inc"

    cseg
HaltSubsys: public HaltSubsys
    pshs a
        do
            lda $FD05
        while mi | wend
        orcc #$50
        lda #$80
        sta $FD05
    puls a
rts

ResumeSubsys: public ResumeSubsys
    clr $FD05
    andcc #not $50
    ; do
    ;     tst $FD05
    ; while pl | wend
    pshs a,b
        ldb #200
        do 
            lda $FD05
            bmi exit
            decb
        while ne | wend
        exit:
    puls a,b
rts

WriteSharedRam: public WriteSharedRam ; (y, b)
    ldy #$FC80
    do
        lda ,x+
        sta ,y+
        decb
    while ne | wend
rts


SendSubsys: public SendSubsys
    pshs a,y
        bsr HaltSubsys
        bsr WriteSharedRam
        bsr ResumeSubsys
    puls a,y
rts


WaitSubsys: public WaitSubsys
    lda #24
    do
        deca
    while ne | wend
rts

EndCommand:
    lda $FC80
    ora #$80
    sta $FC80
rts

    ext subbin
SendSubProgram_unitSize equ 100
    cseg
SendSubProgram_Command:
    defb 0,0
    defb SUB.TEST
    defb 'YAMAUCHI'
    defb $91
    defw $d380+19
SendSubProgramAny:
    do
        pshs a,b,y,cc | orcc #$50
            bsr HaltSubsys
            pshs x
                pshs y
                    ldx #SendSubProgram_Command
                    ldb #14
                    bsr WriteSharedRam
                puls x
                stx ,y++
                ldd #SendSubProgram_unitSize
                std ,y++
                lda #$90
                sta ,y+
            puls x
            ldb #SendSubProgram_unitSize
            pshs cc | orcc #$50 | sta Bank 
                do
                    lda ,x+
                    sta ,y+
                    decb
                while ne | wend
            lda Bank | puls cc
            bsr ResumeSubsys
            bsr WaitSubsys
            bsr HaltSubsys
            bsr EndCommand
            bsr ResumeSubsys
        puls a,b,y,cc
        leay SendSubProgram_unitSize,y
        subd #SendSubProgram_unitSize
    while cc | wend
rts

SendSubProgram: public SendSubProgram
    pshs a,b,x,y
        ldy #subbin_start
        ldx #subbin
        ldd #subbin_size
        bsr SendSubProgramAny

        ; ldy #SubChars
        ; ldx #PatternRamBack+BChar_Space*BackPatternSize
        ; ldd #(BChar_End-BChar_Space)*BackPatternSize
        ; bsr SendSubProgramAny
    puls a,b,x,y
rts
