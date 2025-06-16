BackgroundChars_: public BackgroundChars_
; [0] Ground
defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
; [1] GroundUp
defb 00h,01h,00h,03h,00h,03h,00h,07h
defb 00h,0fh,00h,1fh,00h,3fh,00h,0ffh
; [2] GroundUpUp
defb 01h,0ffh,03h,0ffh,03h,0ffh,07h,0ffh
defb 0fh,0ffh,1fh,0ffh,3fh,0ffh,0ffh,0ffh
; [3] GroundUpDown
defb 01h,00h,03h,80h,03h,0e0h,07h,0f0h
defb 0fh,0f8h,1fh,0fch,3fh,0fch,0ffh,0feh
; [4] GroundDown
defb 00h,00h,80h,00h,0e0h,00h,0f0h,00h
defb 0f8h,00h,0fch,00h,0fch,00h,0feh,00h
; [5] GroundDownDown
defb 0ffh,00h,0ffh,80h,0ffh,0e0h,0ffh,0f0h
defb 0ffh,0f8h,0ffh,0fch,0ffh,0fch,0ffh,0feh
; [6] GroundDownUp
defb 00h,01h,80h,03h,0e0h,03h,0f0h,07h
defb 0f8h,0fh,0fch,1fh,0fch,3fh,0feh,0ffh
; [7] MountainUp
defb 00h,01h,00h,02h,00h,04h,00h,08h
defb 00h,10h,00h,20h,00h,40h,00h,80h
; [8] MountainUpUp
defb 01h,00h,02h,00h,04h,00h,08h,00h
defb 10h,00h,20h,00h,40h,00h,80h,00h
; [9] MountainUpDown
defb 01h,80h,02h,40h,04h,20h,08h,10h
defb 10h,08h,20h,04h,40h,02h,80h,01h
; [10] MountainDown
defb 80h,00h,40h,00h,20h,00h,10h,00h
defb 08h,00h,04h,00h,02h,00h,01h,00h
; [11] MountainDownDown
defb 00h,80h,00h,40h,00h,20h,00h,10h
defb 00h,08h,00h,04h,00h,02h,00h,01h
; [12] MountainDownUp
defb 80h,01h,40h,02h,20h,04h,10h,08h
defb 08h,10h,04h,20h,02h,40h,01h,80h
