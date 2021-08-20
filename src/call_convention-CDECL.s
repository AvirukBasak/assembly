# This code demonstrates the CDECL call convention, uses call stacks

.text
.global _start

_start:
    push        %rbp
    mov         %rsp, %rbp
    
M1: call        main

    pop         %rbp
    mov         %rax, %rdi          # move returned value to rdi, exitcode is this last returned value
    mov         $60, %rax           # 60 is sys_exit code for syscall (64 bit system call)
S1: syscall

main:
    push        %rbp                # backup rbp of caller function
    mov         %rsp, %rbp          # rbp points to base of stack frame
    
    # The following is same as:
    #  long rax = add ('A', 2);
    
    push        $'A'                # arg 1 of add
    push        $2                  # arg 2 of add
AD: call        add                 # call: add (arg1, arg2)
    pop         %rbx
    pop         %rbx
    
    # The following is same as:
    #  char *rcx = {rax, ' ', 'L', 'a', 'n', 'g', '\n', 0};
    #  print (rcx);
    
    push        $0                  # init local empty string variable of 8 bytes
    mov         %rsp, %rcx          # string pointer
    movb        %al,  0(%rcx)       # char 0, calculated using add
    movb        $' ', 1(%rcx)       # char 1
    movb        $'L', 2(%rcx)       # char 2
    movb        $'a', 3(%rcx)       # char 3
    movb        $'n', 4(%rcx)       # char 4
    movb        $'g', 5(%rcx)       # char 5
    movb        $0xA, 6(%rcx)       # char 6
    movb        $0x0, 7(%rcx)       # char 7
P1: call        print               # call print
    pop         %rbx                # pop the local string var
    
    mov         $0, %rax            # optional return 0 statement
    pop         %rbp                # pop original rbp address
    ret                             # return

add:
    push        %rbp                # pushes current stack base pointer
    mov         %rsp, %rbp
     
    mov         16(%rbp), %rax      # rax now points to arg2 of add (arg1, arg2)
    add         24(%rbp), %rax      # 1st arg of add (arg1, arg2)
    
    pop         %rbp                # restore rbp by popping it
    ret                             # return

print:
    push        %rbp
    mov         %rsp, %rbp
    
    mov         $1, %rdi
    mov         %rbp, %rsi
    add         $16, %rsi
    mov         $1, %rdx
    iLoop:
        mov     $1, %rax
        syscall
        cmpb    $0, (%rsi)
        je      return
        inc     %rsi
        jmp     iLoop

    return:
        pop     %rbp
        ret
