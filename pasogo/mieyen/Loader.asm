include "Pasogo.inc"
include "BinSize.inc"

CodeTop equ 0400h

cseg
    cli
    
    ; mov cx,0 
    ; do | wloop

    xor al,al | out NmiMask,al
    mov ax,cs | mov ds,ax
    cld

    mov al,PmuSupply | out Vg230Index,al
    in al,Vg230Data

    mov si,Vg230InitialValues
    lodsw | mov cx,ax
    do
        lodsw
        out VG230Index,ax
        defb 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0
        defb 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0
    wloop

    mov si,CgaInitalValues
    lodsw | mov cx,ax
    mov dx,CgaIndex
    do
        lodsw | out dx,ax
        defb 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0
        defb 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0
    wloop

    mov al,13h | out InterruptController,al ; ICW1
    defb 0ebh,0, 0ebh,0
    mov al,08h | out InterruptController+1,al ; ICW2
    defb 0ebh,0, 0ebh,0
    mov al,09h | out InterruptController+1,al ; ICW4
    defb 0ebh,0, 0ebh,0
    mov al,0ffh | out InterruptController+1,al ; OCW1 : mask
    defb 0ebh,0, 0ebh,0
    mov al,0c7h | out InterruptController,al ; OCW2 : level
    defb 0ebh,0, 0ebh,0

    xor al,al
    mov dx,ParallelPortControl0 | out dx,al
    mov dx,ParallelPortControl1 | out dx,al
    mov dx,ParallelPortControl2 | out dx,al
    mov dx,ParallelPortControl3 | out dx,al

    mov si,MapInitialValues
    lodsw | mov cx,ax
    do
        lodsb | out MapAddress,al
        defb 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0
        defb 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0
        lodsw | out MapData,ax
        defb 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0
        defb 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0, 0ebh,0
    wloop

    mov al,56h | out IntervalTimer+3,al ; counter 1: MSB only, mode 3
    defb 0ebh,0, 0ebh,0

    xor al,al
    out Rtc+0,al
    defb 0ebh,0, 0ebh,0
    out Rtc+1,al
    defb 0ebh,0, 0ebh,0
    out Rtc+2,al
    defb 0ebh,0, 0ebh,0
    out Rtc+3,al
    defb 0ebh,0, 0ebh,0

    out DmaController+13,al ; Master Clear
    defb 0ebh,0, 0ebh,0
    mov al,41h | out DmaController+11,al ; Write Mode Register : channel 1
    defb 0ebh,0, 0ebh,0
    mov al,42h | out DmaController+11,al ; Write Mode Register : channel 2
    defb 0ebh,0, 0ebh,0
    mov al,43h | out DmaController+11,al ; Write Mode Register : channel 3
    defb 0ebh,0, 0ebh,0
    mov al,0ffh
    out DmaController+1,al ; Base&Current Word Count(low) : channel 0
    defb 0ebh,0, 0ebh,0
    out DmaController+1,al ; Base&Current Word Count(high) : channel 0
    defb 0ebh,0, 0ebh,0
    mov al,58h | out DmaController+11,al ; Write Mode Register : channel 0
    defb 0ebh,0, 0ebh,0
    xor al,al
    out DmaController+8,al ; Write Command Register
    defb 0ebh,0, 0ebh,0
    mov al,0eh | out DmaController+15,al ; Write All Mask Register Bits
    defb 0ebh,0, 0ebh,0

    mov al,9 | out IntervalTimer+1,al ; Counter 1 Counter
    defb 0ebh,0, 0ebh,0
    mov al,0 | out IntervalTimer+2,al ; Counter 2 Counter
    mov cx, 1000 | do | wloop

    mov cx,72h
    mov al,BiosTimeBaseHigh | out Vg230Index,al
    defb 0ebh,0
    in al,Vg230Data
    defb 0ebh,0
    do
        mov ah,al
        in al,Vg230Data
        defb 0ebh,0
        neg ah
        add ah,al
        sub cl,ah
        sbb ch,0
    while nc | wend

    mov ax,cs | mov ds,ax
    mov si,LoaderEnd
    xor ax,ax | mov es,ax
    mov di,CodeTop
    mov cx,(BinSize+1)/2
    rep movsw

    xor ax,ax | mov ds,ax | mov ss,ax
    mov sp,0
jmp 0:CodeTop


MapInitialValues:
    defw 26
    defb 80h | defw 9020h
    defb 84h | defw 9021h
    defb 88h | defw 9022h
    defb 8ch | defw 9023h
    defb 90h | defw 9024h
    defb 94h | defw 9025h
    defb 98h | defw 9026h
    defb 9ch | defw 9027h
    defb 0a0h | defw 9028h
    defb 0a4h | defw 9029h
    defb 0a8h | defw 902ah
    defb 0ach | defw 902bh
    defb 0b0h | defw 902ch
    defb 0b4h | defw 902dh
    defb 0c0h | defw 0000h
    defb 0c4h | defw 0000h
    defb 0c8h | defw 0000h
    defb 0cch | defw 0000h
    defb 0d0h | defw 0000h
    defb 0d4h | defw 0000h
    defb 0d8h | defw 0000h
    defb 0dch | defw 0000h
    defb 0e0h | defw 0000h
    defb 0e4h | defw 0000h
    defb 0e8h | defw 903eh
    defb 0ech | defw 903fh

CgaInitalValues:
    defw 7
    defb 0c0h,00h ; Window Start MSB Register
    defb 0c1h,00h ; Window Start LSB Register
    defb 0cah,25h ; LCD Panel Resolution Register :  320x240
    defb 0cbh,00h ; Gray Scale Register
    defb 0cch,00h ; LCD Mode Register
    defb 0c2h,00h ; LCD display Control Register
    defb 0cdh,00h

Vg230InitialValues:
    defw 54
    defb KeyStatus,00h ;  Keyboard Shift and NMI Status Register
    defb Port1NmiLow,00h ; Port 1 NMI Trap Address Low Register
    defb Port1NmiHigh,00h ; Port 1 NMI Trap Address High Register
    defb Port2NmiLow,00h ; Port 2 NMI Trap Address Low Register
    defb Port2NmiHigh,00h ; Port 2 NMI Trap Address High Register
    defb Port3NmiLow,00h ; Port 3 NMI Trap Address Low Register
    defb Port3NmiHigh,00h ; Port 3 NMI Trap Address High Register
    defb PmuNmiMask,7fh ; PMU NMI Mask Register
    defb BusCycleMode,4bh ; Bus Cycle Generator Mode Register
    defb BusCycleWait1,00h ; Bus Cycle Generator Wait State Control 1 Register
    defb BusCycleWait2,00h ; Bus Cycle Generator Wait State Control 2 Register
    defb MemoryControl1,87h ; Memory Control 1 Register
    defb MemoryControl2,21h ; Memory Control 2 Register
    defb DisplayBufferStart,00h ; Alternate Display Buffer Start Address Register
    defb LcdConfig,00h ; LCD Configuration Control Register
    defb KeyMode,25h ; Keyboard Mode Register
    defb KeyScanControl,01h ; Keyboard Scan Control Register
    defb IcuMode,0ach ; ICU Mode Register
    defb DmaMode,0e6h ; DMA Mode Register
    defb SioMode,40h ; SIO Mode Register
    defb SioPowerControl,0c0h ; SIO Power Control Register
    defb TimerMode,00h ; Timer Mode Register
    defb PioMode,00h ; PIO Mode Register
    defb CardMode,70h ; PC Card Controller Mode Register
    defb Card0Control,3ch ; PC Card Slot 0 Control Register
    defb Card0InterruptMask,80h ; PC Card Slot 0 Interrupt Mask Register
    defb Card0High,00h ; PC Card Slot 0 I/O High Address Register
    defb Card0Low,00h ; PC Card Slot 0 I/O Low Address Register
    defb Card0Range,00h ; PC Card Slot 0 I/O Address Range Register
    defb Card1Control,1dh ; PC Card Slot 1 Control Register
    defb Card1InterruptMask,80h ; PC Card Slot 1 Interrupt Mask Register
    defb Card1High,00h ; PC Card Slot 1 I/O High Address Register
    defb Card1Low,00h ; PC Card Slot 1 I/O Low Address Register
    defb Card1Range,00h ; PC Card Slot 1 I/O Address Range Register
    defb CardPowerControl,0a0h ; PC Card Power Control Register
    defb CardActivityTimer,00h ; PC Card Activity Timer Register
    defb GpioMode,0a3h ; GPIO Mode Register
    defb GpioControl,00h ; GPIO Control Register
    defb TopOfMemory,2eh ; Top of Memory Register
    defb RtcMode,00h ; RTC Mode Register
    defb PmuControl,04h ; PMU Control Register
    defb PmuMask,0ffh ; PMU Activity Mask Register
    defb PmuRange,00h ; PMU I/O Range (IORNG) Register
    defb PmuPowerOn,0ffh ; PMU POWER ON (PWRON) Register
    defb PmuPowerDonw,0ffh ; PMU POWER DOZE (PWRDOZE) Register
    defb PmuPowerSleep,0ffh ; PMU POWER SLEEP (PWRSLEEP) Register
    defb PmuPowerSuspend,00h ; PMU POWER SUSPEND (PWRSUSPEND) Register
    defb PmuPolarity,0ffh ; PMU Polarity Register
    defb PmuDozeTimer,00h ; PMU DOZE Timer Register
    defb PmuStatus,00h ; PMU Status Register
    defb PmuSleep,00h ; PMU SLEEP  Register
    defb PmuSuspendTimer,00h ; PMU SUSPEND Timer  Register
    defb PmuLcdTimer,00h ; PMU LCD Timer  Register
    defb PmuLcdSequence,10h ; PMU LCD Sequence  Register

LoaderEnd:
