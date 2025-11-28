ext WaitTimer_

tempo equ 180

Port_Register equ 0188h
Port_Out equ 018ah

Psg_Tone_A equ 0
Psg_Tone_B equ 2
Psg_Tone_C equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_Volume_A equ 8
Psg_Volume_B equ 9
Psg_Volume_C equ 10

Opn_OnOff equ 28h
Opn_Part equ 30h

HighNoise equ 0f0h
LowNoise equ 0f1h

MaxVol equ 63
HighNoiseValue equ 11*12/6
LowNoiseValue equ 27*12/6

PsgCount equ 3
OpnCount equ 3
AllCount equ PsgCount+OpnCount
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
OpnAvailable: public OpnAvailable
    defb 0
Channels defs unitSize*AllCount
time: defw 0
mixerValue: defb 0
wcount:defb 0
shootingTone: defw 0
    defb 0

cseg
WaitPort:
    push ax | push dx
        mov byte ptr [wcount],0
        mov dx,Port_Register
        do
            inc byte ptr [wcount]
            in al,dx
            and al,80h
        while nz | wend
    pop dx | pop ax
ret

Wait1:
    push cx
        mov cl,[wcount]
        do
            dec cl
        while nz | wend
    pop cx
ret

WriteRegister:
; al:register, ah:value
    push dx
        mov dx,Port_Register | out dx,al
        mov al,ah
        mov dx,Port_Out | out dx,al
    pop dx
ret

WriteRegisterW:
; al:register, ah:value
    push dx
        mov dx,Port_Register | out dx,al
        call Wait1
        mov al,ah
        mov dx,Port_Out | out dx,al
    pop dx
ret


BassTone:
    defb 96,96,102,97
    defb 33,40,20,0
    defb 31,31,148,31
    defb 15,5,16,13
    defb 7,6,6,7
    defb 40,23,71,87
    defb 58
; PianoTone:
;     defb 15,82,50,2
;     defb 65,27,0,0
;     defb 94,94,94,158
;     defb 15,8,7,8
;     defb 5,5,5,5
;     defb 214,214,216,216
;     defb 60
; GuiterTone:
;     defb 67,119,79,113
;     defb 10,23,22,8
;     defb 31,31,18,31
;     defb 4,4,1,12
;     defb 1,1,1,0
;     defb 16,16,24,24
;     defb 40
OrganTone:
    defb 114,116,20,18
    defb 50,0,0,0
    defb 31,29,29,29
    defb 20,0,0,0
    defb 0,0,0,0
    defb 72,10,10,10
    defb 54
; OrganTone:
;     defb 1,6,4,4
;     defb 26,33,0,0
;     defb 26,29,26,29
;     defb 0,0,0,0
;     defb 0,0,0,0
;     defb 5,5,8,8
;     defb 36
SnareTone:
    defb 15,0,0,0
    defb 14,19,17,0
    defb 31,31,31,31
    defb 0,24,15,19
    defb 0,0,17,16
    defb 8,184,44,44
    defb 60

Tones:
    defw BassTone,OrganTone,SnareTone

SetTone: public SetTone
    push dx
        mov ch,24
        do
            call WaitPort
            mov al,cl
            mov ah[bx] | inc bx
            call WriteRegisterW
            add cl,4
            dec ch
        while nz | wend
        call WaitPort
        mov al,cl | add al,20h
        mov ah,[bx] | inc bx
        call WriteRegisterW
    pop dx
ret


InitSoundOpn: public InitSoundOpn
    mov ah,(0b8h and 03fh) or 80h
    mov [mixerValue],ah
    mov al,Psg_Mixer
    call WriteRegister

    mov al,Psg_Mixer
    mov dx,Port_Register | out dx,al
    mov dx,Port_Out | in al,dx
    cmp al,[mixerValue]
    if z
        mov byte ptr [OpnAvailable],1

        mov bx,Channels
        xor al,al
        mov ch,AllCount*unitSize
        do
            mov [bx],al | inc bx
            dec ch
        while nz | wend
        xor ax,ax
        mov [time],ax
        mov [shootingTone],ax

        ; mov bx,BassTone
        ; mov cl,Opn_Part+0
        ; call SetTone

        ; mov bx,OrganTone
        ; mov cl,Opn_Part+1
        ; call SetTone

        ; mov bx,SnareTone
        ; mov cl,Opn_Part+2
        ; call SetTone

        mov cx,OpnCount * 256
        do
            call WaitPort
            mov al,Opn_OnOff
            mov ah,cl
            call WriteRegisterW
            inc cl
            dec ch
        while nz | wend
    else
        mov byte ptr [OpnAvailable],0
    endif
ret


; ToneOn:
; ; in
; ;   cx : cycle
;     push ax | push dx
;         mov al,Psg_Tone_A
;         mov dx,Port_Register | out dx,al
;         mov al,cl
;         mov dx,Port_Out | out dx,al
;         mov al,Psg_Tone_A+1
;         mov dx,Port_Register | out dx,al
;         mov al,ch
;         mov dx,Port_Out | out dx,al
;         mov al,Psg_Volume_A
;         mov dx,Port_Register | out dx,al
;         mov al,15
;         mov dx,Port_Out | out dx,al
;     pop dx | pop ax
; ret

; ToneOff:
;     push ax | push dx
;         mov al,Psg_Volume_A
;         mov dx,Port_Register | out dx,al
;         xor al,al
;         mov dx,Port_Out | out dx,al
;     pop dx | pop ax
; ret


; Sound_GetOpn: public Sound_GetOpn
;     push ax | push cx
;         mov cx,283
;         call ToneOn
;         mov al,2
;         call WaitTimer_
;         call ToneOff
;     pop cx | pop ax
; ret


; Sound_HitOpn: public Sound_HitOpn
;     push ax | push cx
;         mov cx,300
;         do
;             call ToneOn
;             mov al,1
;             call WaitTimer_
;             sub cx,10
;             cmp cx,150
;         while nb | wend
;         call ToneOff
;     pop cx | pop ax
; ret


; Sound_MissOpn: public Sound_MissOpn
;     push ax | push cx
;         mov cx,150
;         do
;             call ToneOn
;             mov al,1
;             call WaitTimer_
;             add cx,10
;             cmp cx,300
;         while b | wend
;         call ToneOff
;     pop cx | pop ax
; ret


; Sound_LooseOpn: public Sound_LooseOpn
;     push ax | push cx
;         mov cx,1000
;         call ToneOn
;         mov al,6
;         call WaitTimer_
;         call ToneOff
;     pop cx | pop ax
; ret


SoundHandlerOpn: public SoundHandlerOpn
    push ax | push dx | push bx
        mov bx,[shootingTone]
        or bx,bx
        if nz
            mov al,Psg_Tone_A
            mov ah,bl
            call WriteRegister
            mov al,Psg_Tone_A+1
            mov ah,bh
            call WriteRegister
            add bx,15
            cmp bx,300
            if nb
                mov ax,Psg_Volume_A
                call WriteRegister
                xor bx,bx
            endif
            mov [shootingTone],bx
        endif

        mov ax,[time]
        sub ax,tempo
        if b
            push ax | push cx | push si
                mov si,Channels
                mov cx,PsgCount*100h ; ch=count; cl=register
                mov dl,[mixerValue]
                mov dh,1
                do
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr [si+Channel_Len]
                        if z
                            continue:
                            mov al,[bx]
                            or al,al
                            if z
                                ; end
                                push dx
                                    mov word ptr [si+Channel_Ptr],0
                                    mov al,cl
                                    add al,Psg_Volume_A
                                    xor ah,ah
                                    call WriteRegister
                                pop dx
                                jmp next
                            endif
                            inc al
                            if z 
                                ; repeat
                                mov bx,[si+Channel_Start]
                                jmp continue
                            endif
                            dec al
                            mov [si+Channel_Len],al
                            inc bx
                            mov al,[bx]
                            inc bx
                            mov [si+Channel_Ptr],bx
                            cmp al,HighNoise
                            if e
                                mov bl,HighNoiseValue
                                WriteNoise:
                                mov al,Psg_Noise
                                mov ah,bl
                                call WriteRegister
                               
                                or dl,dh
                                mov al,dh
                                shl al,1 | shl al,1 | shl al,1
                                not al
                                and dl,al
                                mov ah,dl
                                mov al,Psg_Mixer
                                call WriteRegister

                                mov byte ptr [si+Channel_Vol],MaxVol
                                jmp EndWriteCycle
                            endif
                            cmp al,LowNoise
                            if z
                                mov bl,LowNoiseValue
                                jmp WriteNoise
                            endif
                            or al,al
                            if nz
                                dec al
                                shl al,1
                                xor ah,ah
                                add ax,cycles
                                mov bx,ax
                                mov al,cl
                                shl al,1
                                push ax
                                    mov ah,[bx]
                                    call WriteRegister
                                pop ax
                                inc bx
                                inc al
                                mov ah,[bx]
                                call WriteRegister

                                mov byte ptr [si+Channel_Vol],MaxVol
                                
                                mov al,dh
                                shl al,1 | shl al,1 | shl al,1
                                or dl,al
                                mov al,dh
                                not al
                                and dl,al
                                mov ah,dl
                                mov al,Psg_Mixer
                                call WriteRegister
                            else
                                mov byte ptr [si+Channel_Vol],0
                            endif
                            EndWriteCycle:
                        endif
                        mov al,cl
                        add al,Psg_Volume_A
                        mov ah,[si+Channel_Vol]
                        shr ah,1 | shr ah,1
                        call WriteRegister

                        mov al,[si+Channel_Vol]
                        or al,al
                        if nz
                            dec al
                            mov [si+Channel_Vol],al
                        endif
                    endif
                    next:
                    inc cl
                    add si,unitSize
                    shl dh
                    dec ch
                while nz | wend
                mov [mixerValue],dl

                mov cx,300h ; ch=count; cl=channel
                do
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr [si+Channel_Len]
                        if z
                            mov al,[si+Channel_Vol]
                            or al,al
                            if nz
                                call WaitPort
                                mov al,Opn_OnOff
                                mov ah,cl
                                call WriteRegisterW
                                mov byte ptr [si+Channel_Vol],0
                            endif
                            continue2:
                            mov al,[bx]
                            or al,al
                            if z
                                ; end
                                mov word ptr [si+Channel_Ptr],0
                                jmp next2
                            endif
                            inc al
                            if z 
                                ; repeat
                                mov bx,[si+Channel_Start]
                                jmp continue2
                            endif
                            dec al
                            mov [si+Channel_Len],al
                            inc bx
                            mov al,[bx]
                            inc bx
                            mov [si+Channel_Ptr],bx
                            or al,al
                            if nz
                                dec al
                                shl al,1
                                xor ah,ah
                                add ax,OpnScales
                                mov bx,ax

                                mov al,cl
                                add al,0a4h
                                call WaitPort
                                mov ah,[bx]
                                inc bx
                                call WriteRegisterW

                                mov al,cl
                                add al,0a0h
                                call WaitPort
                                mov ah,[bx]
                                call WriteRegisterW

                                push bx | push cx
                                    mov bl,cl
                                    add cl,Opn_Part
                                    add bl,bl
                                    xor bh,bh
                                    add bx,Tones
                                    mov bx,[bx]
                                    call SetTone
                                pop cx | pop bx

                                call WaitPort
                                mov al,Opn_OnOff
                                mov ah,cl
                                or ah,0f0h
                                call Wait1
                                call WriteRegisterW
                                mov byte ptr [si+Channel_Vol],0ffh
                            endif
                        endif
                    endif
                    next2:
                    inc cl
                    add si,unitSize
                    dec ch
                while nz | wend
            pop si | pop cx | pop ax
            add ax,600
        endif
        mov [time],ax
    pop bx | pop dx | pop ax
ret


Melody0:
    cli
        mov [Channels+unitSize*0+Channel_Ptr],bx
        mov byte ptr [Channels+unitSize*0+Channel_Len],1
        mov word ptr [shootingTone],0
        push ax | push dx
            mov al,Psg_Volume_A
            mov dx,Port_Register | out dx,al
            xor al,al
            mov dx,Port_Out | out dx,al
        pop dx | pop ax
    sti
ret

MelodyWait0:
    call Melody0
    do
        cmp word ptr [Channels+unitSize*0+Channel_Ptr],0
    while nz | wend
ret 


Melody4:
    cli
        mov [Channels+unitSize*4+Channel_Ptr],bx
        mov byte ptr [Channels+unitSize*4+Channel_Len],1
        mov word ptr [shootingTone],0
        push ax | push dx
            mov al,Psg_Volume_A
            mov dx,Port_Register | out dx,al
            xor al,al
            mov dx,Port_Out | out dx,al
        pop dx | pop ax
    sti
ret

MelodyWait4:
    call Melody4
    do
        cmp word ptr [Channels+unitSize*4+Channel_Ptr],0
    while nz | wend
ret 


Sound_FireOpn: public Sound_FireOpn
    push ax| push bx | push dx
        cmp word ptr [Channels++Channel_Ptr],0
        if z
            cli
                mov word ptr [Channels++Channel_Ptr],0

                mov word ptr [shootingTone],150
                mov al,Psg_Volume_A
                mov dx,Port_Register | out dx,al
                mov al,15
                mov dx,Port_Out | out dx,al
                mov al,[mixerValue]
                and al,0f8h
                or al,88h
                mov [mixerValue],al
                mov ah,al
                mov al,Psg_Mixer
                mov dx,Port_Register | out dx,al
                mov al,ah
                mov dx,Port_Out | out dx,al
                mov al,Psg_Volume_A
                mov dx,Port_Register | out dx,al
                mov al,15
                mov dx,Port_Out | out dx,al
            sti
        endif
    pop dx | pop bx | pop ax
ret

beep_notes:
    defb 1,A4, 0
Sound_BeepOpn: public Sound_BeepOpn
    push ax | push bx
        mov bx,beep_notes
        call MelodyWait0
    pop bx | pop ax
ret

smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBangOpn: public Sound_SmallBangOpn
    push ax | push bx
        mov bx,smallExplosion_notes
        call Melody0
    pop bx | pop ax
ret

largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBangOpn: public Sound_LargeBangOpn
    push ax | push bx
        mov bx,largeExplosion_notes
        call Melody0
    pop bx | pop ax
ret

up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_UpOpn: public Sound_UpOpn
    push ax | push bx
        mov bx,up_notes
        call Melody0
    pop bx | pop ax
ret


start_notes:
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_StartOpn: public Sound_StartOpn
    push ax | push bx
        mov bx,start_notes
        call MelodyWait4
    pop bx | pop ax
ret

; clear_notes: 
;     defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
;     defb 0
; Sound_ClearOpn: public Sound_ClearOpn
;     push ax | push bx
;         mov bx,clear_notes
;         call MelodyWait4
;     pop bx | pop ax
; ret

over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOverOpn: public Sound_GameOverOpn
    push ax | push bx
        mov bx,over_notes
        call MelodyWait4
    pop bx | pop ax
ret


BGM_B: 
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,B4, N4P,G4, N2,G4, N2P,0
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,G5, N4P,D5, N2,D5, N2P,0
    defb N4P,F5, N4P,E5, N2,F5, N4,F5, N4,E5, N4,F5
    defb N4P,E5, N4P,C5, N2,C5, N2P,0
    
    defb N8,A4, N8,A4, N8,B4, N4,C5, N4,C5, N8,C5
    defb N8,B4, N8,B4, N8,C5, N4,D5, N4,D5, N8,D5
    defb N8,C5, N8,C5, N8,D5, N4,E5, N4,E5, N8,E5
    defb N8,F5, N4,F5, N4P,E5, N4,0

    defb 0ffh

BGM_C:
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3

    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N4,F3, N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,F3
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3

    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4
    
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N8,D4, N8,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N8,F3, N8,F3, N8,0, N4P,E3, N4,0

    defb 0ffh

BGM_D:
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4
    
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N8,0, N8,A4, N8,A4, N8,A4
    
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4

    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N8,0, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    ; defb N4,0, N8,A4, N8,A4, N4,0, N4,A4,  N4,0, N8,A4, N8,A4, N4,0, N4,A4
    ; defb N4,0, N8,A4, N8,A4, N4,0, N4,A4,  N8,0, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4

    defb 0ffh


StartBGMOpn: public StartBGMOpn
    push ax | push bx
        cli
            mov al,1
            mov bx,BGM_B
            mov [Channels+unitSize*4+Channel_Start],bx
            mov [Channels+unitSize*4+Channel_Ptr],bx
            mov [Channels+unitSize*4+Channel_Len],al
            mov bx,BGM_C
            mov [Channels+unitSize*3+Channel_Start],bx
            mov [Channels+unitSize*3+Channel_Ptr],bx
            mov [Channels+unitSize*3+Channel_Len],al
            mov bx,BGM_D
            mov [Channels+unitSize*5+Channel_Start],bx
            mov [Channels+unitSize*5+Channel_Ptr],bx
            mov [Channels+unitSize*5+Channel_Len],al
        sti
    pop bx | pop ax
ret

StopBGMOpn: public StopBGMOpn
    push ax | push bx | push cx | push dx
        cli
            mov bx,0
            mov [Channels+unitSize*4+Channel_Ptr],bx
            mov [Channels+unitSize*3+Channel_Ptr],bx
            mov [Channels+unitSize*5+Channel_Ptr],bx

            mov cx,2*256 or Psg_Volume_B
            do
                mov al,cl
                mov dx,Port_Register | out dx,al
                xor al,al
                mov dx,Port_Out | out dx,al
                inc cl
                dec ch
            while nz | wend
            mov ch,300h
            do
                call WaitPort
                mov al,Opn_OnOff
                mov dx,Port_Register | out dx,al
                call Wait1
                mov al,cl
                mov dx,Port_Out | out dx,al
                inc cl
                dec ch
            while nz | wend
        sti
    pop dx | pop cx | pop bx | pop ax
ret

E3 equ 1
F3 equ 2
F3S equ 3
G3 equ 4
G3S equ 5
A3 equ 6
A3S equ 7
B3 equ 8
C4 equ 9
C4S equ 10
D4 equ 11
D4S equ 12
E4 equ 13
F4 equ 14
F4S equ 15
G4 equ 16
G4S equ 17
A4 equ 18
A4S equ 19
B4 equ 20
C5 equ 21
C5S equ 22
D5 equ 23
D5S equ 24
E5 equ 25
F5 equ 26
F5S equ 27
G5 equ 28

N8 equ 3
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defw 757 ; E3
defw 714 ; F3
defw 674 ; F#3
defw 636 ; G3
defw 601 ; G#3
defw 567 ; A3
defw 535 ; A#3
defw 505 ; B3
defw 477 ; C4
defw 450 ; C#4
defw 424 ; D4
defw 401 ; D#4
defw 378 ; E4
defw 357 ; F4
defw 337 ; F#4
defw 318 ; G4
defw 300 ; G#4
defw 283 ; A4
defw 267 ; A#4
defw 252 ; B4
defw 238 ; C5
defw 225 ; C#5
defw 212 ; D5
defw 200 ; D#5
defw 189 ; E5
defw 178 ; F5
defw 168 ; F#5
defw 159 ; G5

OpnScales:
defb 19,11 ; E3
defb 19,57 ; F3
defb 19,106 ; F#3
defb 19,158 ; G3
defb 19,213 ; G#3
defb 20,16 ; A3
defb 20,78 ; A#3
defb 20,143 ; B3
defb 26,106 ; C4
defb 26,143 ; C#4
defb 26,182 ; D4
defb 26,223 ; D#4
defb 27,11 ; E4
defb 27,57 ; F4
defb 27,106 ; F#4
defb 27,158 ; G4
defb 27,213 ; G#4
defb 28,16 ; A4
defb 28,78 ; A#4
defb 28,143 ; B4
defb 34,106 ; C5
defb 34,143 ; C#5
defb 34,182 ; D5
defb 34,223 ; D#5
defb 35,11 ; E5
defb 35,57 ; F5
defb 35,106 ; F#5
defb 35,158 ; G5
