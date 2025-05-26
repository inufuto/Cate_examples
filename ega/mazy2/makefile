name=mazy2

comname=$(name)

all: $(name)_img.zip $(comname).com

cseg_fd=0500
dseg_fd=3f00
cseg_com=0100
dseg_com=3b00

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h VVram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h 
Chars.obj: Chars.asm 
Loader2D.obj: Loader2D.asm BinSize.inc
Loader2DD.obj: Loader2DD.asm BinSize.inc
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
SoundBeep.obj: SoundBeep.asm 
SoundOpl.obj: SoundOpl.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj SoundBeep.obj \
	SoundOpl.obj StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate86.lib

$(comname).com.bin: $(objects) makefile
	LinkLE.exe $(comname).com.bin $(cseg_com) $(dseg_com) $(objects)
	copy $(comname).com.symbols.txt $(comname)_com.symbols.txt /y

$(comname).com: $(comname).com.bin $(comname)_com.symbols.txt MakeCom.csx makefile
	dotnet script MakeCom.csx $(comname)

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg_fd) $(dseg_fd) $(objects)
	copy $(name).symbols.txt $(name)_fd.symbols.txt /y

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name)

Loader2D.bin: Loader2D.obj BinSize.inc makefile 
	LinkLE.exe Loader2D.bin 0000 0000 Loader2D.obj
	copy Loader2D.bin debug.bin /y

Loader2DD.bin: Loader2DD.obj BinSize.inc makefile 
	LinkLE.exe Loader2DD.bin 0000 0000 Loader2DD.obj
	copy Loader2DD.bin debug.bin /y

$(name)_2d.d88 $(name)_2d.img: $(name).bin Loader2D.bin Disk2D.csx
	dotnet script Disk2D.csx $(name)

$(name)_2dd.d88 $(name)_2dd.img: $(name).bin Loader2DD.bin Disk2DD.csx
	dotnet script Disk2DD.csx $(name)

$(name)_img.zip: $(name)_2d.d88 $(name)_2d.img $(name)_2dd.d88 $(name)_2dd.img
	7z a $(name)_img.zip $(name)_2d.d88 $(name)_2d.img $(name)_2dd.d88 $(name)_2dd.img
