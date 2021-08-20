# Demonstrates basic arithmetic using assembly
.text
.global _start
_start:
    mov $5, %rax
    mov $8, %rbx
    call add
    mov $rslt, %rsi
    mov $4, %rdx
    call print
    call exit

add:
    add %rbx, %rax
    mov %rax, rslt
    ret

print:
    mov $1, %rax
    mov $1, %rdi
    syscall
    ret

exit:
    mov $60, %rax
    mov $0, %rdi
    syscall

.data
rslt:
    .int 0
