DAC equ $8000

ToneSampleCount equ 16
ChannelCount equ 3

zseg
SubToneSamples: public SubToneSamples
    defs ToneSampleCount*ChannelCount
SubNoiseSamples: public SubNoiseSamples
    defs 32
SubVolumes: public SubVolumes
    defs ChannelCount
SubCycles: public SubCycles
    defs ChannelCount
values:
    defs ChannelCount
denoms:
    defs ChannelCount
offsets:
    defs ChannelCount
SumValue:
    defb 0
pSamples:
    defw 0
mul1:
    defb 0
mul2:
    defb 0
mul3:
    defb 0
wordV:
    defw 0

cseg
SubMain: public SubMain
    ldx #$ff | txs | cld

    sei
        stz <pSamples+1
        ldx #0
        do
            stz <SubVolumes,x
            stz <denoms,x
            stz <values,x
            stz <offsets,x
            inx
            cpx #ChannelCount
        while ne | wend

                ; lda #67 | sta SubCycles
                ; lda #7 | sta SubVolumes

                ; lda #53 | sta SubCycles+1
                ; lda #7 | sta SubVolumes+1

                ; lda #45 | sta SubCycles+1
                ; lda #7 | sta SubVolumes+1
    cli
lll: 
jmp lll


Mul:
    sta <mul1
    stz <mul3
    lda <SubVolumes,x | sta <mul2
    do
        lda <mul2
    while ne
        lsr a | sta <mul2
        if cs
            lda <mul3
            clc|adc <mul1
            sta <mul3
        endif
        asl <mul1
    wend
    lda <mul3
    lsr a | lsr a | lsr a
    sta values,x
rts


SubIrq: public SubIrq
    pha | phx | phy
        lda #SubToneSamples | sta <pSamples
        stz <SumValue
        ldx #0
        do
            lda <SubVolumes,x
            if ne
                lda <denoms,x
                sec|sbc #24 | sta <denoms,x
                if cc
                    ldy <offsets,x
                    lda (<pSamples),y
                    jsr Mul
                    iny
                    tya
                    and #$0f
                    sta <offsets,x

                    lda <denoms,x
                    clc|adc <SubCycles,x
                    sta <denoms,x
                endif

                lda <SumValue
                clc|adc <values,x
                sta <SumValue
            endif
            lda <pSamples
            clc|adc #ToneSampleCount
            sta <pSamples

            inx
            cpx #ChannelCount
        while ne | wend
        lda <SumValue
                stz <wordV+1
                asl a | rol <wordV+1
                clc|adc <SumValue | sta <wordV
                lda <wordV+1 | adc #0
                lsr a | ror <wordV
                lda <wordV
        sta DAC
        ; lda <denom
        ; inc a
        ; and #31 | sta <denom
        ; if eq
        ;     ldx <offset
        ;     lda SubNoiseSamples,x
        ;     sta DAC
        ;     inx
        ;     txa
        ;     and #$3f
        ;     sta <offset
        ; endif
    ply | plx | pla
rti

SubNmi: public SubNmi
rti
