# Include this file to output string to the terminal
# The string MUST end with a null character
# The string pointer must be moved to rsi before function call

# WARNING: do NOT hold important values in the 4 general purpose registers while calling this function
#          all the 4 registers are overwritten during function call

.text
OUTPUT.print:
    mov     $1, %rdi
    callq   OUTPUT._write
    retq

OUTPUT.println:
    mov     $1, %rdi
    callq   OUTPUT._write
    mov     $OUTPUT.nlf, %rsi
    callq   OUTPUT._write
    retq

OUTPUT.printerr:
    mov     $2, %rdi
    callq   OUTPUT._write
    mov     $OUTPUT.nlf, %rsi
    callq   OUTPUT._write
    retq

OUTPUT._write:
    mov     $1, %rdx                  # no. of chars to print at a time
    
    OUTPUT.oLoop:
        cmpb    $0, (%rsi)            # compare binary, null char with dereferenced %rsi
        je      OUTPUT.oReturn        # if null, return
        mov     $1, %rax              # 1 is code for sys_write kernel function for 64 bit systems
        syscall                       # call kernel
        inc     %rsi                  # increase rsi, i.e. point to next char
        jmp     OUTPUT.oLoop          # repeat all the above stuff
    
    OUTPUT.oReturn:
        retq

.data
OUTPUT.nlf:
    .byte 0x0a, 0                     # .byte BYTES (comma seperated), in this case, the new LF and string term
