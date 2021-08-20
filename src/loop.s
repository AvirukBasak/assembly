# Demonstrates loops by printing from A to Z
# To understand this code, you must first understand how output is given in assembly

.text
.global _start
_start:
    iLoop:
        callq print            # calls print
        addb $1, char          # add a byte to char, so A becomes B, B becomes C, etc
        cmp $91, char          # 2nd oprnd of cmp shld be a writable memory, result of comparison is always stored in rax
        je exit
        jmp iLoop

print:
    mov $1, %rax
    mov $1, %rdi
    mov $char, %rsi
    mov $1, %rdx
    syscall
    ret

exit:
    movb $0x0a, char           # prints LF before exitting
    call print
    mov $60, %rax
    mov $0, %rdi
    syscall

.data
char: .byte 0x41
