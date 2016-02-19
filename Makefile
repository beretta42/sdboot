# A Makefile for booting os9


all: boot.dsk


boot.dsk: boot.bin
	rm -f boot.dsk
	decb dskini boot.dsk
	decb copy -b -2 boot.bin boot.dsk,BOOT.BIN
	decb copy -a -0 -l AUTOEXEC.BAS boot.dsk,AUTOEXEC.BAS


boot.bin: boot.asm sd.asm
	lwasm -mboot.map -oboot.bin boot.asm


clean: 
	rm -f boot.dsk boot.bin
