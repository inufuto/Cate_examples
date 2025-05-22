;****** 00-1F ********* TIA REGISTERS ******************

INPTCTRL equ $01     ;Input control                                write-only

INPT0    equ $08     ;Paddle Control Input 0                       read-only
INPT1    equ $09     ;Paddle Control Input 1                       read-only
INPT2    equ $0A     ;Paddle Control Input 2                       read-only
INPT3    equ $0B     ;Paddle Control Input 3                       read-only

; ** some common alternate names for INPT0/1/2/3
INPT4B   equ $08     ;Joystick 0 Fire 0                            read-only
INPT4A   equ $09     ;Joystick 0 Fire 1                            read-only
INPT5B   equ $0A     ;Joystick 1 Fire 0                            read-only
INPT5A   equ $0B     ;Joystick 1 Fire 1                            read-only
INPT4R   equ $08     ;Joystick 0 Fire 0                            read-only
INPT4L   equ $09     ;Joystick 0 Fire 1                            read-only
INPT5R   equ $0A     ;Joystick 1 Fire 0                            read-only
INPT5L   equ $0B     ;Joystick 1 Fire 1                            read-only

INPT4    equ $0C     ;Player 0 Fire Button Input                   read-only
INPT5    equ $0D     ;Player 1 Fire Button Input                   read-only

AUDC0    equ $15     ;Audio Control Channel 0                      write-only
AUDC1    equ $16     ;Audio Control Channel 1                      write-only
AUDF0    equ $17     ;Audio Frequency Channel 0                    write-only
AUDF1    equ $18     ;Audio Frequency Channel 1                    write-only
AUDV0    equ $19     ;Audio Volume Channel 0                       write-only
AUDV1    equ $1A     ;Audio Volume Channel 1                       write-only

;****** 20-3F ********* MARIA REGISTERS ***************

BACKGRND equ $20     ;Background Color                             write-only
P0C1     equ $21     ;Palette 0 - Color 1                          write-only
P0C2     equ $22     ;Palette 0 - Color 2                          write-only
P0C3     equ $23     ;Palette 0 - Color 3                          write-only
WSYNC    equ $24     ;Wait For Sync                                write-only
P1C1     equ $25     ;Palette 1 - Color 1                          write-only
P1C2     equ $26     ;Palette 1 - Color 2                          write-only
P1C3     equ $27     ;Palette 1 - Color 3                          write-only
MSTAT    equ $28     ;Maria Status                                 read-only
P2C1     equ $29     ;Palette 2 - Color 1                          write-only
P2C2     equ $2A     ;Palette 2 - Color 2                          write-only
P2C3     equ $2B     ;Palette 2 - Color 3                          write-only
DPPH     equ $2C     ;Display List List Pointer High               write-only
P3C1     equ $2D     ;Palette 3 - Color 1                          write-only
P3C2     equ $2E     ;Palette 3 - Color 2                          write-only
P3C3     equ $2F     ;Palette 3 - Color 3                          write-only
DPPL     equ $30     ;Display List List Pointer Low                write-only
P4C1     equ $31     ;Palette 4 - Color 1                          write-only
P4C2     equ $32     ;Palette 4 - Color 2                          write-only
P4C3     equ $33     ;Palette 4 - Color 3                          write-only
CHARBASE equ $34     ;Character Base Address                       write-only
P5C1     equ $35     ;Palette 5 - Color 1                          write-only
P5C2     equ $36     ;Palette 5 - Color 2                          write-only
P5C3     equ $37     ;Palette 5 - Color 3                          write-only
OFFSET   equ $38     ;Unused - Store zero here                     write-only
P6C1     equ $39     ;Palette 6 - Color 1                          write-only
P6C2     equ $3A     ;Palette 6 - Color 2                          write-only
P6C3     equ $3B     ;Palette 6 - Color 3                          write-only
CTRL     equ $3C     ;Maria Control Register                       write-only
P7C1     equ $3D     ;Palette 7 - Color 1                          write-only
P7C2     equ $3E     ;Palette 7 - Color 2                          write-only
P7C3     equ $3F     ;Palette 7 - Color 3                          write-only

;****** 280-2FF ******* PIA PORTS AND TIMERS ************

SWCHA    equ $280    ;P0, P1 Joystick Directional Input            read-write
SWCHB    equ $282    ;Console Switches                             read-write
CTLSWA   equ $281    ;I/O Control for SCHWA                        read-write
SWACNT   equ $281    ;VCS name for above                           read-write
CTLSWB   equ $283    ;I/O Control for SCHWB                        read-write
SWBCNT   equ $283    ;VCS name for above                           read-write

INTIM    equ $284    ;Iterval Timer Read                           read-only
TIM1T    equ $294    ;Set 1    CLK Interval (838   nsec/interval)  write-only
TIM8T    equ $295    ;Set 8    CLK Interval (6.7   usec/interval)  write-only
TIM64T   equ $296    ;Set 64   CLK Interval (63.6  usec/interval)  write-only
T1024T   equ $297    ;Set 1024 CLK Interval (858.2 usec/interval)  write-only
TIM64TI  equ $29E    ;Interrupt timer 64T                          write-only