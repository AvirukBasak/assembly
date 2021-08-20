# Demonstrating printing a string by calculating its length
# This form of length calculation is done execution time instead of compile time
# which is recommeded for predefined strings like in this case.

.text
.global _start
_start:
    mov $1, %rax              # 1 is code for sys_write (Linux only, for DOS, it is 2)
    mov $1, %rdi              # Output stream, 1 is stdout, 2 is stderr

    mov $buffer, %rsi         # Stores starting address of string "Hello world!\n", i.e. a pointer
    mov $len, %rdx            # Now rdx points to len
    sub %rsi, %rdx            # calculates the length, $len brings address at label len. The sabtraction gives no. of bytes from $buffer to $len
    mov %rdx, len             # stores calculated length back in len
    syscall                   # System call asks the kernel to do something by interrupting the current processes
    
    mov $0, %rdi              # exitcode 0
    callq EXIT                # Calling function EXIT, defined below

EXIT:                         # Function EXIT, this is crucial, otherwise the CPU goes on executing, causing seg fault
    mov $60, %rax             # 60 is code for sys_exit kernel function
    syscall

.data                         # The '.data' section, contains 'variables'
buffer:                       # Variable 'buffer', signifies an address and hence is just a pointer to 'H'
    .ascii "Hello world!\n"   # This means data in that buffer is ascii and not numeric value
len:
    .int 0                    # Length of buffer
