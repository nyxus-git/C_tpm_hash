#!/bin/bash

# Compile the C file
gcc -m16 -ffreestanding -fno-pic -c -o main.o main.c

# Assemble the assembly file
as --32 -o boot.o boot.s

# Link the object files
ld -m elf_i386 -T linker.ld -o boot.bin boot.o main.o --oformat binary

# Create a bootable image
dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
echo -n -e '\x55\xAA' | dd of=boot.img bs=1 seek=510 conv=notrunc

#create bootable image with pendrive
sudo dd if=boot.img of=/dev/sdc bs=4M


