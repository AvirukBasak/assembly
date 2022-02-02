## Creeve

```
fn main () {
    int a = 5,
    b = 7;
}
```

## Assembly

```
.text
.global _start

_start:
  callq main
  callq exit

main:
  pushq %rbp
  movq %rsp, %rbp
  movq $5, -8 (%rbp)
  movq $7, -16 (%rbp)
  movq $0, %rax
  pop %rbp
  retq

exit:
  movq %rax, %rdi
  movq $60, %rax
  syscall

```

---

## Creeve

```
fn add (a, b) {
    return a + b;
}

fn main () {
    var a = 5;
    var b = 7;
    return add (a, b);
}

```

## Assembly

```
.text
.global _start

_start:
  callq main
  callq exit

add:
  pushq %rbp
  movq %rsp, %rbp
  movq 16 (%rbp), %rax
  addq 24 (%rbp), %rax
  pop %rbp
  retq
  
main: 
  pushq %rbp
  movq %rsp, %rbp
  movq $5 -8 (%rbp)
  movq $7 -16 (%rbp)
  pushq -16 (%rbp)
  pushq -8 (%rbp)
  callq add
  pop %rbp
  retq

exit:
  movq %rax, %rdi
  movq $60, %rax
  syscall

```
