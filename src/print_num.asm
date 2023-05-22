section .data
    buf times 64 db 0   ; buffer to store the printed digits


section .text
    global print_char
    global print
    global exit
    global main
    global _start
    global start


; rsi: character or string to print
; rdx: number of bytes to write
print_chars:
    mov rax, 1                  ; code for sys_write
    mov rdi, 1                  ; code for stdout
    syscall
    ret


; rax: number to print
