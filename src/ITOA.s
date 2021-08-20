.text
.include "libs/OUTPUT.s"
.global _start
_start:
    movl        $1, ITOA.num
    callq       ITOA.convert
    mov         $ITOA.str, %rsi
    callq       OUTPUT.println
    callq       ITOA.exit

ITOA.convert:
    mov         $10, %rbx
    push        $0
    
    ITOA.convert.push.loop:
        callq   ITOA.mod
        add     $48, %rax
        push    %rax
        cmp     $0, %rcx
        je      ITOA.convert.pop
        jmp     ITOA.convert.push.loop
    
    ITOA.convert.pop:
        mov     $ITOA.str, %rcx

    ITOA.convert.pop.loop:
        pop     (%rcx)
        cmpb    $0, (%rcx)
        je      ITOA.convert.ret
        inc     %rcx
        jmp     ITOA.convert.pop.loop

    ITOA.convert.ret:
        mov     ITOA.str, %rcx
        retq
        

ITOA.mod:
    mov         $0, %rcx
    ITOA.mod.loop:
        cmp     %ebx, ITOA.num
        jl      ITOA.mod.ret
        cmpl    $0, ITOA.num
        je      ITOA.mod.ret
        sub     %ebx, ITOA.num
        inc     %rcx
        jmp     ITOA.mod.loop

    ITOA.mod.ret:
        retq

ITOA.exit:
    mov         $60, %rax
    mov         $0, %rdi
    syscall

.data
ITOA.num:
    .int 0

ITOA.popped:
    .byte 0

ITOA.str:
    .fill 129, 1, 0
