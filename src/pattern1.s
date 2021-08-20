# This prints the following pattern
#
# 1 2 3 4 5
# 2 3 4 5
# 3 4 5
# 4 5
# 5
#

.text
.global _start

_start:
    mov         %rsp, %rbp
    sub         $0x04, %rsp
    movb        $1, -0x04(%rbp)         # variable byte i
    movb        $'1', -0x03(%rbp)       # variable byte j
    movb        $' ', -0x02(%rbp)       # char variable for space
    movb        $'\n', -0x1(%rbp)       # char varable for new line
    mov         %rsp, %rsi              # posn of variable i
    inc         %rsi                    # posn of j, i.e. the value to be printed
    
    iLoop:
        cmpb        $5, -0x04(%rbp)     # i <= 5
        je          iEnd
        jLoop:
            cmpb    $'5', -0x03(%rbp)
            je      jEnd
            call    printChar
            inc     %rsi
            call    printChar
            incb    -0x03(%rbp)
            jmp     jLoop
        jEnd:
        inc         %rsi
        call        printChar
        sub         $2, %rsi
        incb        -0x04(%rbp)         # i++
        jmp         iLoop
    
    iEnd:
    
    add         $0x02, %rsp
    mov         %rax, %rdi
    mov         $60, %rax
    syscall

printChar:
    mov         $1, %rax
    mov         $1, %rdi
    mov         $1, %rdx
    syscall
    ret
