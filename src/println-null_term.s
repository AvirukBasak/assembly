# This code prints a string by incrementing the string pointer
# Printing stops once the string terminator (null char) is found

.text
.global _start
_start:
    mov $out, %rsi                # %rsi stores starting address of character buffer str 
    callq PRINT
    mov $0, %rdi                  # exitcode
    callq EXIT

PRINT:
    mov $1, %rdi
    mov $1, %rdx                  # no. of chars to print at a time
    oLoop:
        cmpb $0, (%rsi)           # compare binary, null char with dereferenced %rsi
        je oReturn                # if null, return
        mov $1, %rax              # 1 is code for sys_write kernel function
        syscall                   # call kernel
        inc %rsi                  # increase rsi, i.e. point to next char
        jmp oLoop                 # repeat all the above stuff
    oReturn: retq

EXIT:
    mov $60, %rax                 # 60 is code for sys_exit kernel function, NOTE: rdi stores exitcode
    syscall

.data
out:                              # charcter buffer str starts here
    .ascii "This is a string!\n"
    .byte 0                       # str ends after this line (byte directive, tells assembler to put a byte of 0 value in this place)

linefeed:
    .byte 0x0a, 0                 # .byte BYTES (comma seperated), in this case, the new LF and string term
