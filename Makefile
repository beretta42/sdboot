# A Makefile for booting os9


all: boot.dsk


boot.dsk: boot.bin
	rm -f boot.dsk
	decb dskini boot.dsk
	decb copy -b -2 boot.bin boot.dsk,BOOT.BIN


boot.bin: boot.asm sd.asm
	lwasm -m boot.map -o boot.bin $^


clean: 
	rm -f boot.dsk boot.bin
