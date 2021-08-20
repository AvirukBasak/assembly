# Include this file to use INPUT function for reading strings
# Read input is stored in both variable input and register RCX
# Size of input can be changed before calling the function by modifying input_size variable and fill TIMES of input variable

# WARNING: do NOT hold important values in the 4 general purpose registers before function call
#          all 4 registers are overwritten during function execution

.text
INPUT.readln:
    mov         $0, %rdi                         # 0 is device code for stdin
    mov         $1, %rdx                         # no. of chars to read at a time
    mov         $INPUT.input, %rsi               # addr of input is stored in rsi, i.e. pointer
    
    INPUT.iLoop:
        mov     $0, %rax                         # 0 is code for sys_read for 64 bit systems
        syscall                                  # calls kernel
        cmpb    $0x0a, (%rsi)                    # compares 0x0a with lowest 8 bits of dereferenced %rsi i.e. a char of the string, cmpb is "compare byte"
        je      INPUT.iReturn                    # jmp if the character is 0x0a, to iReturn
        mov     %rsi, %rax                       # otherwise store addr of current char in rax
        sub     $INPUT.input, %rax               # sub the init addr ftom current adr to find len
        cmp     INPUT.input_size, %rax           # compare the two. if length reached, overflow has hapenned
        je      INPUT.overflow_action            # if rax is 0, je is true, i.e. all characters are full, so overflow hapenned, handled at overflow label
        inc     %rsi                             # otherwise increase addr of current char, point to next char memory
        jmp     INPUT.iLoop                      # repeat all the above stuff
    
    INPUT.overflow_action:
        mov     $INPUT.input, %rsi               # re-initializes rsi with starting addr of input
        callq   INPUT.readln                     # read in the remaining characters, if overflow happens in that as well, process repeats
        mov     $INPUT.msg_overflow, %rsi        # after all chars are read in, even the overflow bytes, rsi points to error msg
        retq
    
    INPUT.iReturn:
        movb    $0, (%rsi)                       # null terminate input
        mov     $INPUT.input, %rsi               # rsi points to starting of input
        retq                                     # return

.data
INPUT.input:
    .fill 129, 1, 0                              # .fill TIMES, SIZE, VALUE

INPUT.input_size:
    .quad 128                                    # size of input, quad word

INPUT.msg_overflow:
    .ascii "\033[31mINPUT:\033[0m error: input overflow"
    .byte 0
