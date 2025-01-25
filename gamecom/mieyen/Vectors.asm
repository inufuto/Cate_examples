ext Handler

cseg
    defs 0039h
Vectors: public Vectors
    iret | nop | nop ; TIM0
    iret | nop | nop ; EXTINT
    iret | nop | nop ; UART
    iret | nop | nop ; LCDC
    jmp t,Handler ; TIM1
    iret | nop | nop ; CK
    iret | nop | nop ; PIO
    iret | nop | nop ; WDTINT
    iret | nop | nop ; NMI
VectorsEnd:public VectorsEnd


;  1000  10 85 10 6A 10 85 10 6D 10 70 10 85 10 85 10 73   ...j...m.p.....s
;  1010  10 85 10 76 10 85 10 79 10 85 10 7C 10 7F 10 82   ...v...y...|....

;  106A  jmp  T,$2039 ; TIM0
;  106D  jmp  T,$203C ; EXTINT
;  1070  jmp  T,$203F ; UART
;  1073  jmp  T,$2042 ; LCDC
;  1076  jmp  T,$2045 ; TIM1
;  1079  jmp  T,$2048 ; CK
;  107C  jmp  T,$204B ; PIO
;  107F  jmp  T,$204E ; WDTINT
;  1082  jmp  T,$2051 ; NMI
;  1085  iret ; DMA,
