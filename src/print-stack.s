.text
.global _start
_start: 
    push    p2              # not more or less than 8 bytes can be pushed at a time
    push    p1
   
    mov     %rsp, %rsi      # rsi points to address in rsp
    mov     $12, %rdx       # 12 bytes, each push is 8 bytes
    mov     $1, %rax        # sys_write
    mov     $1, %rdi        # stdout
    syscall                 # interrupt
    
exit:
    mov     $60, %rax
    mov     $0, %rdi
    syscall

.data
p1: .byte 'H', 'E', 'L', 'L', 'O', 0x20, 'W', 'O'
p2: .byte 'R', 'L', 'D', 0x0a, 0, 0 ,0 ,0
