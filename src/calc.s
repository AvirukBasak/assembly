# This code is a simple calculator app
# This code will RUN ONLY on Linux 64 bit
# To understand this code, you need to understand assembly I/O, loops, using cmp opcode, and opcode suffixes
# Suffixes: eg: differences of mov, movb, movl, etc

.include "libs/INPUT.s"
.include "libs/OUTPUT.s"

.text
.global _start
_start:
    mov $choice, %rsi
    callq OUTPUT.print
    callq INPUT.readln
    
    mov $num1, %rsi
    callq OUTPUT.print
    callq INPUT.readln

    mov $0, %rdi
    callq EXIT

EXIT:
    mov $60, %rax                 # 60 is code for sys_exit kernel function, NOTE: rdi stores exitcode
    syscall                       # call kernel

.data
inp:
    .fill 129, 1, 0               # .fill TIMES, SIZE, VALUE: fills a space of TIMES x SIZE bytes with VALUE, with each value being SIZE bytes

out:
    .fill 129, 1, 0

choice:
    .ascii " Enter 1 to add\n"    # .ascii STRING
    .ascii " Enter 2 to sub\n"
    .ascii " Enter 3 to mul\n"
    .ascii " Enter 4 to div\n"
    .ascii "Choose: "
    .byte 0                       # .byte BYTE, in this case, the null char

num1:
    .ascii "Enter num 1: "
    .byte 0

num2:
    .ascii "Enter num 2: "
    .byte 0

msg_overflow:
    .ascii "\033[31mcalc\033[0m: error: input overflow\n"
    .byte 0
