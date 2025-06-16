name=guntus

filename=$(name)

all: $(filename) $(name).wav $(name).rom $(name).d88 $(name).dsk

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Vram.h Sprite.h Stage.h Chars.h \
	Coord.h 
Direction.asm: Direction.c Direction.h Vram.h 
Enemy.asm: Enemy.c Enemy.h Coord.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h Vram.h \
	Coord.h Chars.h Math.h 
EnemyRow.asm: EnemyRow.c EnemyRow.h Coord.h Vram.h Stage.h Chars.h \
	MovingEnemy.h Sound.h Bang.h Enemy.h Math.h Status.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Fighter.h \
	CopyMemory.h 
Fighter.asm: Fighter.c Fighter.h Vram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Sound.h Status.h Coord.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h Vram.h \
	Sound.h Coord.h Chars.h MovingEnemy.h EnemyRow.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Status.h Sound.h Coord.h Chars.h 
Main.asm: Main.c Init.h Stage.h ScanKeys.h Sprite.h Fighter.h \
	FighterBullet.h EnemyBullet.h Status.h Bang.h Sound.h Team.h \
	Stage.h MovingEnemy.h Direction.h Sprite.h EnemyRow.h Vram.h \
	Star.h Enemy.h Item.h Coord.h 
MovingEnemy.asm: MovingEnemy.c MovingEnemy.h Sprite.h Chars.h Direction.h Math.h \
	Coord.h EnemyRow.h Status.h EnemyBullet.h Sound.h Bang.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Enemy.h \
	Fighter.h Vram.h Item.h 
Stage.asm: Stage.c Stage.h Stages.h Math.h Fighter.h FighterBullet.h \
	EnemyRow.h MovingEnemy.h Status.h Sprite.h Vram.h Team.h \
	Stage.h MovingEnemy.h Direction.h Sprite.h EnemyBullet.h Star.h \
	Bang.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Vram.h Chars.h Coord.h 
Status.asm: Status.c Status.h Vram.h Print.h Chars.h Sprite.h \
	Init.h EnemyRow.h 
Team.asm: Team.c Team.h Stage.h MovingEnemy.h Direction.h Sprite.h \
	Coord.h Enemy.h 
Vram.asm: Vram.c Vram.h Chars.h EnemyRow.h Star.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
CopyMemory.obj: CopyMemory.asm 
Init.obj: Init.asm BIOS.inc 
Loader.obj: Loader.asm BIOS.inc BinSize.inc
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm BIOS.inc 
Sprite.obj: Sprite.asm BIOS.inc Vram.inc Chars.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc Chars.inc 
VramB.obj: VramB.asm BIOS.inc Vram.inc Chars.inc 

objects = Main.obj \
	Bang.obj Direction.obj Enemy.obj EnemyBullet.obj EnemyRow.obj Fighter.obj \
	FighterBullet.obj Item.obj MovingEnemy.obj Stage.obj Stages.obj Star.obj \
	Status.obj Team.obj Vram.obj Chars.obj CopyMemory.obj Init.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	VramB.obj \
	..\..\cate\cate80.lib


$(name).rom: chead.obj $(objects) makefile
	LinkLE.exe $(name).rom 4000 e000 chead.obj $(objects)
	copy $(name).symbols.txt $(name).rom.symbols.txt /y

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex 8300 8000 $(objects)
	copy $(name).symbols.txt $(name).disk.symbols.txt /y

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)

$(name).cas: $(objects) makefile
	LinkLE.exe $(name).cas C220 C000 $(objects)
	copy $(name).symbols.txt $(name).tape.symbols.txt /y

$(name).wav: $(name).cas
	cas2wav $(name).cas $(name).wav


BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) 8300

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin 8300 8000 $(objects)

Loader.bin: Loader.obj makefile
	LinkLE Loader.bin c000 c100 Loader.obj

$(name).d88 $(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
