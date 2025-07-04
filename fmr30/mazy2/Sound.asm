DcsgPort equ 40h

Dcsg_ToneA equ 00h
Dcsg_VolumeA equ 10h
Dcsg_ToneB equ 20h
Dcsg_VolumeB equ 30h
Dcsg_ToneC equ 40h
Dcsg_VolumeC equ 50h
Dcsg_NoiseControl equ 60h
Dcsg_NoiseVolume equ 70h

MinVolume equ 63

Tempo equ 220

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*count
time:
    defw 0


cseg
InitSound: public InitSound
    xor ax,ax
    mov bx,Channels
    mov cl,count*unitSize
    do
        mov [bx],al | inc bx
        dec cl
    while nz | wend
    mov word ptr[time],ax

    call StopBGM_
ret

WriteByte:
    push dx
        mov dx,DcsgPort
        out dx,al
    pop dx
ret


SoundHandler: public SoundHandler
    mov ax,[time]
    sub ax,Tempo
    if c
        push ax | push bx | push dx | push si
            mov si,Channels
            mov dx,(count * 100h) or Dcsg_ToneA   ; dh = count; dl = register
            do
                mov bx,[si+Channel_Ptr]
                or bx,bx
                if nz
                    dec byte ptr[si+Channel_Len]
                    if z
                        continue:
                        mov al,[bx]
                        or al,al
                        if z
                            ; end
                            mov word ptr[si+Channel_Ptr],0
                            mov al,dl
                            or al,9fh
                            call WriteByte
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
                        mov al,[bx] | inc bx
                        mov [si+Channel_Ptr],bx
                        or al,al
                        if nz
                            add al,al
                            xor ah,ah
                            add ax,cycles
                            push bx
                                mov bx,ax
                                mov al,dl
                                or al,80h
                                or al,[bx]
                                call WriteByte
                                inc bx
                                mov al,[bx]
                                call WriteByte
                                cmp dl,Dcsg_ToneC
                                if z
                                    mov al,4
                                else
                                    xor al,al
                                endif
                            pop bx
                            mov [si+Channel_Vol],al
                        else
                            mov byte ptr [si+Channel_Vol],MinVolume
                        endif
                        EndWriteCycle:
                    endif
                    mov al,[si+Channel_Vol]
                    shr al,1 | shr al,1
                    or al,dl
                    or al,90h
                    call WriteByte
                    mov al,[si+Channel_Vol]
                    cmp al,MinVolume
                    if nz
                        inc al
                        mov [si+Channel_Vol],al
                    endif
                endif
                next:
                add dl,20h
                add si,unitSize
                
                dec dh
            while nz | wend
        pop si | pop dx | pop bx | pop ax
        add ax,600/2
    endif
    mov [time],ax
ret


Melody:
    cli
        mov [Channels+unitSize*0+Channel_Ptr],bx
        mov byte ptr [Channels+unitSize*0+Channel_Len],1
    sti
ret

MelodyWait:
    call Melody
    do
        cmp word ptr [Channels+unitSize*0+Channel_Ptr],0
    while nz | wend
ret 


beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push ax | push bx
        mov bx,beep_notes
        call MelodyWait
    pop bx | pop ax
ret


Sound_Get_: public Sound_Get_
    push bx
        mov bx,beep_notes
        call Melody
    pop bx
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push bx
        mov bx,hit_notes
        call Melody
    pop bx
ret


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push bx
        mov bx,loose_notes
        call MelodyWait
    pop bx
ret


start_notes: 
    defb N8,C4, N8,G4, N8,E4, N8,G4, N2,C5
    defb 0
Sound_Start_: public Sound_Start_
    push bx
        mov bx,start_notes
        call MelodyWait
    pop bx
ret

clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5
    defb 0
Sound_Clear_: public Sound_Clear_
    push bx
        mov bx,clear_notes
        call MelodyWait
    pop bx
ret

over_notes: 
    defb N8,C5, N8,G4, N8,E4, N8,C5,  N8,B4, N8,G4, N8,E4, N8,B4,  N4,A4, N4,B4,  N2,C5
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push bx
        mov bx,over_notes
        call MelodyWait
    pop bx
ret


BGM_B:
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,A4
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,F4
    defb 0ffh

BGM_C:
    defb N4P,0
    defb N4P,F3, N4P,F3, N4,F3
    defb N4P,C3, N4P,C3, N4,C3
    defb N2,F3, N2,G3, N2+N8,A3, N4P,0
    defb N4P,A3, N4P,A3, N4,A3
    defb N4P,G3, N4P,G3, N4,G3
    defb N2,F3, N2,C3, N2+N8,F3
    defb 0ffh

StartBGM_: public StartBGM_
    push ax | push bx
        cli
            mov al,1
            mov bx,BGM_B
            mov [Channels+unitSize*1+Channel_Start],bx
            mov [Channels+unitSize*1+Channel_Ptr],bx
            mov [Channels+unitSize*1+Channel_Len],al
            mov bx,BGM_C
            mov [Channels+unitSize*2+Channel_Start],bx
            mov [Channels+unitSize*2+Channel_Ptr],bx
            mov [Channels+unitSize*2+Channel_Len],al
        sti
    pop bx | pop ax
ret

StopBGM_: public StopBGM_

    push ax | push cx
        cli
            xor ax,ax
            mov [Channels+unitSize*1+Channel_Ptr],ax
            mov [Channels+unitSize*2+Channel_Ptr],ax
            mov cl,3
            mov al,Dcsg_VolumeB or 8fh
            do
                call WriteByte
                add al,20h
                dec cl
            while nz | wend
        sti
    pop cx | pop ax
ret


B2 equ 1
C3 equ 2
C3S equ 3
D3 equ 4
D3S equ 5
E3 equ 6
F3 equ 7
F3S equ 8
G3 equ 9
G3S equ 10
A3 equ 11
A3S equ 12
B3 equ 13
C4 equ 14
C4S equ 15
D4 equ 16
D4S equ 17
E4 equ 18
F4 equ 19
F4S equ 20
G4 equ 21
G4S equ 22
A4 equ 23
A4S equ 24
B4 equ 25
C5 equ 26
C5S equ 27
D5 equ 28
D5S equ 29
E5 equ 30
F5 equ 31
F5S equ 32
G5 equ 33

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defb 4,63 ; B2
defb 11,59 ; C3
defb 5,56 ; C3S
defb 3,53 ; D3
defb 3,50 ; D3S
defb 6,47 ; E3
defb 11,44 ; F3
defb 3,42 ; F3S
defb 13,39 ; G3
defb 9,37 ; G3S
defb 8,35 ; A3
defb 8,33 ; A3S
defb 10,31 ; B3
defb 13,29 ; C4
defb 2,28 ; C4S
defb 9,26 ; D4
defb 1,25 ; D4S
defb 11,23 ; E4
defb 5,22 ; F4
defb 1,21 ; F4S
defb 14,19 ; G4
defb 12,18 ; G4S
defb 12,17 ; A4
defb 12,16 ; A4S
defb 13,15 ; B4
defb 14,14 ; C5
defb 1,14 ; C5S
defb 4,13 ; D5
defb 8,12 ; D5S
defb 13,11 ; E5
defb 2,11 ; F5
defb 8,10 ; F5S
defb 15,9 ; G5
