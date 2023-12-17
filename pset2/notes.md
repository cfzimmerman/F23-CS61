Get a list of all functions in the bomb:

```bash
objdump -t -C bomb | grep 'F .text'
```

Start GDB:

```bash
gdb -ix bomb.gdb
```

Get summary of current breakpoints:

```bash
info break
```

Get contents of a register

```bash
info registers eax
# or
i r eax
```

Read the value of a register as something (ex. s for string)

```bash
x /s $rdi
# or reference rbp
x /w $rbp-0x4
```

Conclude execution of a function I accidentally stepped into

```bash
finish
```

Read register value as 32-bit decimal

```bash
x /1wd $r12
```

Print pointer address as array

```bash
print /lu *$rdx@6
```
