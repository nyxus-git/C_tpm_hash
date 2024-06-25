.code16
.global _start
.section .text
_start:
    cli                     # Disable interrupts
    xorw %ax, %ax           # Zero out the data segment register
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
    movw $0x7c00, %sp       # Set stack pointer

    call main               # Call main function

    hlt                     # Halt the CPU

print_string:
    lodsb                   # Load byte at address DS:SI into AL, then increment SI
    or %al, %al             # Test if AL is zero (end of string)
    jz .done                # If zero, end of string, jump to .done
    mov $0x0E, %ah          # BIOS teletype function
    int $0x10               # BIOS interrupt
    jmp print_string        # Repeat for next character
.done:
    ret

halt:
    hlt                     # Halt the CPU
    jmp halt                # Infinite loop to halt

.section .data
hello_world_msg:
    .ascii "Hello, World!\r\n"

