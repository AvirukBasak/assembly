# This code demonstrates the INPUT.s and OUTPUT.s library usage

.include "libs/INPUT.s"                             # include directive, similar to C. this simply copies contents of the file and pastes them here
.include "libs/OUTPUT.s"

.text
.global _start
_start:
    movq    $8, INPUT.input_size                    # input size, i.e. no. of chars to be read set to 8
    mov     $prompt, %rsi                           # store prompt string pointer in rsi
    callq   OUTPUT.print                            # call print
    callq   INPUT.readln                            # read characters till new line or overflow
    cmpq    $INPUT.msg_overflow, %rsi               # if overflow, rsi is set to overflow msg. this checks if that has happened
    je      overflow                                # if that has happened, handle overflow. in this case, the msg is printed
    mov     $prefix, %rsi                           # otherwise store the 1st output in rsi
    callq   OUTPUT.println                          # call println
    mov     $INPUT.input, %rsi                      # store the input in rsi
    callq   OUTPUT.println                          # call println

exit:
    mov     $60, %rax                               # code for sys_exit
    mov     $0, %rdi                                # exitcode
    syscall                                         # kernel call

overflow:
    callq   OUTPUT.printerr                         # since rsi points already to msg_overflow, we can go ahead and call println
    jmp     exit                                    # and then quit the program

.data
prompt:                                             # the input prompt
    .ascii "Enter String: "
    .byte 0

prefix:                                             # 1st output
    .ascii "The input was:"
    .byte 0
