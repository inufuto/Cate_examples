name=antiair

all: $(name).wav

cseg=4000 # CALL 16384
dseg=6700

.c.asm:
	Cate61s.exe $*.c

.asm.obj:
	Asm61s.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Sprite.h Movable.h \
	Stage.h 
Block.asm: Block.c Block.h Movable.h Sprite.h Movable.h VVram.h \
	CopyMemory.h Bang.h Movable.h Sound.h Cannon.h Movable.h \
	Status.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Movable.h VVram.h Sound.h \
	Cannon.h Movable.h Ufo.h Stage.h Block.h Movable.h 
Cannon.asm: Cannon.c Cannon.h Movable.h VVram.h Sprite.h Movable.h \
	ScanKeys.h Bullet.h Block.h Movable.h Bang.h Movable.h \
	Sound.h 
Main.asm: Main.c Status.h ScanKeys.h Sound.h Stage.h Cannon.h \
	Movable.h Sprite.h Movable.h Bullet.h Vram.h VVram.h \
	Ufo.h Stage.h Bang.h Movable.h Block.h Movable.h 
Stage.asm: Stage.c Stages.h Stage.h Vram.h VVram.h Math.h \
	Status.h Sprite.h Movable.h Cannon.h Movable.h Bullet.h \
	Ufo.h Stage.h Bang.h Movable.h Block.h Movable.h 
Stages.asm: Stages.c Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Sprite.h Movable.h Print.h \
	Cannon.h Movable.h 
Ufo.asm: Ufo.c Ufo.h Stage.h VVram.h Movable.h CopyMemory.h \
	Bang.h Movable.h Sound.h Block.h Movable.h Math.h \
	Status.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Sound.h \
	Ufo.h Stage.h 
CopyMemory.obj: CopyMemory.asm InternalRam.inc 
Math.obj: Math.asm InternalRam.inc 
Print.obj: Print.asm InternalRam.inc 
ScanKeys.obj: ScanKeys.asm InternalRam.inc 
Sound.obj: Sound.asm InternalRam.inc 
Sprite.obj: Sprite.asm InternalRam.inc Vram.inc VVram.inc 
Startup.obj: Startup.asm InternalRam.inc 
VramA.obj: VramA.asm InternalRam.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm InternalRam.inc VVram.inc 

objects = Startup.obj \
	Bang.obj Block.obj Bullet.obj Cannon.obj Main.obj Stage.obj \
	Stages.obj Status.obj Ufo.obj Vram.obj VVram.obj CopyMemory.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate61s.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).wav: $(name).bin makefile
	bin2wav.exe --pc=1350 --addr=0x$(cseg) $(name).bin
