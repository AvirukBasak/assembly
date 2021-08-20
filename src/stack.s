.text
.global _start
_start:     
    push        $0x0a
    push        $'!'
    push        $'d'
    push        $'l'
    push        $'r'
    push        $'o'
    push        $'w'
    push        $0x20
    push        $'o'
    push        $'l'
    push        $'l'
    push        $'e'
    push        $'H' 
    
    iLoop:
        pop     popped
        mov     $popped, %rsi
        mov     $1, %rdx
        callq   PRINT
        cmpb    $0x0a, (%rsi)
        je      EXIT
        jmp     iLoop

PRINT:
    mov         $1, %rax
    mov         $1, %rdi
    syscall
    retq

EXIT:
    mov         $60, %rax
    mov         $0, %rdi
    syscall

.data
popped:
    .byte 0
