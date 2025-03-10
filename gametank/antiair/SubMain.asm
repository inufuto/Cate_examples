DAC equ $8000

ToneSampleCount equ 16
ChannelCount equ 3
NoiseSampleCount equ 64

zseg
SubToneSamples: public SubToneSamples
    defs ToneSampleCount*ChannelCount
SubNoiseSamples: public SubNoiseSamples
    defs NoiseSampleCount
SubVolumes: public SubVolumes
    defs ChannelCount
SubCycles: public SubCycles
    defs ChannelCount
SubNoiseVolume: public SubNoiseVolume
    defb 0
SubNoiseCycle: public SubNoiseCycle
    defb 0
values:
    defs ChannelCount
denoms:
    defs ChannelCount
offsets:
    defs ChannelCount
noiseValue:
    defb 0
noiseClock:
    defb 0
noiseOffset:
    defb 0
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
        stz SubNoiseVolume
        stz noiseOffset
        stz noiseClock
    cli
lll: 
jmp lll


Mul:
    sta <mul1
    stz <mul3
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
rts


SubIrq: public SubIrq
    pha | phx | phy
        lda #SubToneSamples | sta <pSamples
        stz <SumValue
        ldx #0
        do
            lda <SubVolumes,x
            if ne
                sta <mul2
                lda <denoms,x
                sec|sbc #24 | sta <denoms,x
                if cc
                    ldy <offsets,x
    
                    lda (<pSamples),y
                    jsr Mul
                    sta values,x

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

        lda <SubNoiseVolume
        if ne
            sta <mul2
            lda <noiseClock
            if eq
                lda <noiseOffset
                inc a
                and #NoiseSampleCount-1
                sta <noiseOffset
                tax
                lda <SubNoiseSamples,x
                jsr Mul
                sta <noiseValue
                lda <SubNoiseCycle
            else
                dec a    
            endif
            sta <noiseClock

            lda <SumValue
            clc|adc <noiseValue
            sta <SumValue
        endif

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
