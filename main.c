void print_string(char *str);  // Forward declaration

void main() {
    char hello_world_msg[] = "Hello, World!\r\n";
    print_string(hello_world_msg);
    while(1);  // Infinite loop to prevent the CPU from executing undefined instructions
}

void print_string(char *str) {
    while (*str) {
        asm volatile (
            "movb $0x0E, %%ah\n\t"
            "movb %0, %%al\n\t"
            "int $0x10\n\t"
            : : "r"(*str++) : "ah", "al"
        );
    }
}

