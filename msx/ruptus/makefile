name=ruptus

filename=$(name)

all: $(filename) $(name).wav $(name).rom $(name).d88 $(name).dsk

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Window.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Stage.h Stages.h Window.h Chars.h \
	Sprite.h Bang.h Main.h Mover.h Sound.h 
Direction.asm: Direction.c Direction.h 
Enemy.asm: Enemy.c Enemy.h Stage.h Fighter.h Window.h Sprite.h \
	Chars.h Direction.h Main.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Enemy.h Sprite.h Enemy.h Stage.h \
	Window.h Chars.h Direction.h Fighter.h Barrier.h Stage.h \
	Fort.h Stage.h 
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h Window.h Chars.h \
	Direction.h ScanKeys.h FighterBullet.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Main.h Status.h \
	Sound.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h Window.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Stage.h \
	Fort.h Stage.h Sound.h 
Fort.asm: Fort.c Fort.h Stage.h Stages.h Window.h Chars.h \
	Bang.h Main.h Mover.h Status.h Sound.h 
Item.asm: Item.c Item.h Stage.h Window.h Sprite.h Chars.h \
	Mover.h 
Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Sprite.h \
	Window.h Fort.h Stage.h Fighter.h Barrier.h Stage.h \
	Star.h Enemy.h FighterBullet.h EnemyBullet.h Enemy.h Status.h \
	Bang.h Item.h Sound.h 
Mover.asm: Mover.c Mover.h 
Stage.asm: Stage.c Stage.h Stages.h Window.h Fighter.h Fort.h \
	Stage.h Barrier.h Stage.h Enemy.h FighterBullet.h Bang.h \
	Sprite.h EnemyBullet.h Enemy.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Fighter.h Window.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Chars.h \
	Print.h Sprite.h 
Vram1.asm: Vram1.c Vram.h Chars.h 
Window.asm: Window.c Window.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
Init.obj: Init.asm BIOS.inc 
Loader.obj: Loader.asm BIOS.inc BinSize.inc
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm BIOS.inc 
Sprite.obj: Sprite.asm BIOS.inc Vram.inc 
Vram0.obj: Vram0.asm BIOS.inc Vram.inc 

objects = Main.obj \
	Bang.obj Barrier.obj Direction.obj Enemy.obj EnemyBullet.obj Fighter.obj \
	FighterBullet.obj Fort.obj Item.obj Mover.obj Stage.obj Stages.obj \
	Star.obj Status.obj Vram1.obj Window.obj Chars.obj Init.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj Vram0.obj \
	..\..\cate\cate80.lib

$(name).rom: chead.obj $(objects) makefile
	LinkLE.exe $(name).rom 4000 e000 chead.obj $(objects)
	copy $(name).symbols.txt $(name).rom.symbols.txt /y

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex 8500 8000 $(objects)
	copy $(name).symbols.txt $(name).disk.symbols.txt /y

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)

$(name).cas: $(objects) makefile
	LinkLE.exe $(name).cas 8500 8000 $(objects)
	copy $(name).symbols.txt $(name).tape.symbols.txt /y

$(name).wav: $(name).cas
	cas2wav $(name).cas $(name).wav


BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) 8500

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin 8500 8000 $(objects)

Loader.bin: Loader.obj makefile
	LinkLE Loader.bin c000 c100 Loader.obj

$(name).d88 $(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
