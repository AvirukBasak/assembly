section .data
    buf times 64 db 0           ; buffer to store the printed digits


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
print_num:
    mov rcx, 10                 ; we'll use this for division later
    mov rdi, 0                  ; initialize the index to zero
    .loop:
        xor rdx, rdx            ; clear rdx for division
        div rcx                 ; divide rax by 10, quotient in rax, remainder in rdx
        add dl, '0'             ; convert the digit to ASCII
        mov byte [buf+rdi], dl  ; store the digit in the buffer
        inc rdi                 ; increment the index
        cmp rax, 0
        jne .loop

    xor rbx, rbx                ; rbx = 0
    lea rcx, [rdi-1]            ; rcx = len -1
    .revstr:
        mov ah, byte [buf+rbx]
        mov al, byte [buf+rcx]
        mov byte [buf+rbx], al
        mov byte [buf+rcx], ah
        inc rbx
        dec rcx
        cmp rbx, rcx
        jl .revstr

    mov byte [buf+rdi], 10      ; put a newline
    inc rdi                     ; increment the index

    mov rsi, buf                ; pass the buffer address to rsi
    mov rdx, rdi                ; pass the length (index) to rdx
    call print_chars
    ret


; rax: exit code
exit:
    mov edi, eax                ; 32 bit exit code is loaded into edi
    mov rax, 60                 ; code for sys_exit
    syscall
    ret


main:
    mov rbx, 69
    lea rax, [ebx]
    call print_num
    mov rbx, 69
    lea rax, [ebx]
    call print_num
    xor eax, eax                ; zero out eax, eax contains exit code
    ret


start:
    call main
    call exit


_start:
    call main
    call exit
