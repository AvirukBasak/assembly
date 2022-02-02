## Creeve

```rust
fn main () {
    int a = 5,
    b = 7;
}
```

## Assembly

```assembly
.text
.global _start

_start:
  call main()
  call exit(rax)

main():
  push %rbp
  movq %rsp, %rbp
  movq $5, -8 (%rbp)
  movq $7, -16 (%rbp)
  movq $0, %rax
  pop %rbp
  ret

exit(rax):
  movq %rax, %rdi
  movq $60, %rax
  syscall

```

## Creeve

```rust
fn sum (a, b) {
    return a + b;
}

fn main () {
    var a = 5;
    var b = 7;
    return sum (a, b);
}

```

## Assembly

```assembly
.text
.global _start

_start:
  call main()
  call exit(rax)

sum(i64,i64):
  push %rbp
  movq %rsp, %rbp
  movq 16 (%rbp), %rax
  add 24 (%rbp), %rax
  pop %rbp
  ret

main():
  push %rbp
  movq %rsp, %rbp
  movq $5 -8 (%rbp)
  movq $7 -16 (%rbp)
  push -16 (%rbp)
  push -8 (%rbp)
  call sum(i64,i64)
  pop %rbp
  ret

exit(rax):
  movq %rax, %rdi
  movq $60, %rax
  syscall

```
