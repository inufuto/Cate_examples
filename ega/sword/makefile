name=sword

comname=$(name)

all: $(name)_img.zip $(comname).com

cseg_fd=0500
dseg_fd=4000
cseg_com=0100
dseg_com=3c00

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe -v2 $*.asm

Ball.asm: Ball.c Ball.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h Sprite.h Movable.h Chars.h Enemy.h \
	Movable.h Man.h Movable.h 
Enemy.asm: Enemy.c Enemy.h Movable.h Stage.h Movable.h Monster.h \
	Movable.h Ball.h Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Movable.h \
	Sound.h Man.h Movable.h Monster.h Movable.h Ball.h \
	Movable.h Point.h Movable.h Vram.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h Chars.h ScanKeys.h Sound.h Monster.h Movable.h \
	Status.h Main.h Point.h Movable.h OneUp.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h Sprite.h Movable.h Chars.h Math.h \
	Man.h Movable.h Enemy.h Movable.h Sound.h Point.h \
	Movable.h OneUp.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
OneUp.asm: OneUp.c OneUp.h Movable.h Sprite.h Movable.h Chars.h \
	Math.h Main.h Stage.h Movable.h Sound.h Status.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Chars.h \
	Main.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h VVram.h Chars.h Man.h Movable.h Monster.h \
	Movable.h Ball.h Movable.h Status.h Point.h Movable.h \
	Math.h OneUp.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h VVram.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Sprite.h Movable.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h 
Chars.obj: Chars.asm 
Loader2D.obj: Loader2D.asm BinSize.inc 
Loader2DD.obj: Loader2DD.asm BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
SoundBeep.obj: SoundBeep.asm 
SoundOpl.obj: SoundOpl.asm 
StageA.obj: StageA.asm Vram.inc Chars.inc 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Ball.obj Enemy.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Point.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj \
	Sound.obj SoundBeep.obj SoundOpl.obj StageA.obj VramA.obj VVramA.obj \
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
