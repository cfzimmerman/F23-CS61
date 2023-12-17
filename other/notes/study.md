1A: 8 bytes = 64 bits
1B: RAX doesn't have an address, it's a register
1C: (2)
1D: Code, Static Data, Heap, Stack
1E: Accessing a random unallocated pointer, dereferencing a null pointer, writing past the end of an allocated array
1F: 110 elements, 440 bytes

2A: What if `it` is either end or the entry before end? If end, end++ will cause issues. If entry before end, the dereference will cause issues. Emily needs to verify the pointer is valid before (1) incrementing it and (2) dereferencing it.
2B: What if Emily is mallocing the last space in the segmented array such that ptr + sz exceeds the global allocation array? She needs to check if she has valid space to insert the magic_ptr there. - She's trying to stick an int into an arbitrary location. However, that space might not be aligned for an int. This would cause an alignment warning.
2C: Why are recomputing padded size in a different way than earlier? Also, active allocs already contains padded size, so this double counts.

3A: The alignment is that of its greatest constituent. That's the char\* pointer, which has alignof 8. So, the alignment is 8.
3B: 48 with padding
3C: 4 bytes after int line
3D: No, this is optimal
3E: 0 bytes padding. x86-64 max_align is 16!
3F: `header + 1`, that moves the pointer sizeof(header) past header
3G:

```c++
void *payload_to_header(void *payload) {
  header *hd = (header *)payload - 1;
  return (void *)hd;
}
```

3H:

```c++
header *next_header(header *hdr) {
  char *nxt = ((char *)hdr + hdr->size);
  if (nxt < default_buffer.buffer + default_buffer.size) {
    return (header *)nxt;
  }
  return nullptr;
}
```

3I:

```c++
header *previous_header(header *hdr) {
  if (hdr->prev_size == 0) {
    return nullptr;
  }
  return (header *)((char *)hdr - hdr->prev_size);
}
```

4A: check_sizes_valid and check_addresses_in_buffer are redundant; check_contiguous and check_non_overlapping are redundant
4B: `assert(last == default_buffer.buffer + default_buffer.size)` after 51
4C: assert(a.second.padding > 0);
4D: `bool invalid_or_double = it == allocs.end() || it->second.free;`
4E: Louise is never coalescing, so she's splitting her allocations into smaller and smaller chunks. Those chunks then get checked by multiple O(n) complexity checker functions on line 102. Implementing coalescing and commenting out the invariant checks should really help. She's also filling up her allocations with 0-sized chunks.
4F: Invariant: Every chunk must have greater than 0 bytes. line 116: `assert(end_ptr != split_ptr)`
4G: When Louisa looks for an allocation, she looks for size matching what she needs. Nut padding takes up space too. She doesn't shift padding to size during deallocations, so her memory space effectively shrinks at every allocation. In dealloc line 84, she should set size += padding and padding = 0
4H: She's searching for space for sz but putting sz + padding there. What if sz + paddding exceeds the available spot?
4I:

```c++
bool is_coalesced() {
    bool prev_free = false;
    for (auto &a : allocs) {
        if (!(prev_free && a.second.free)) {
            return false;
        }
        prev_free = a.second.free;
    }
    return true;
}
```

5A: Function might take no args, might pass arg to a different function instead
5B: The function might use %rdi in intermediate computations;the function might need to save the contents of rdi before calling a child function
5C: The function might be an infinite loop, or it might jump to another function
5D: (2), (4)
5E: (1), (2), (3), (5)
5F: (2), (4)
5G: The stack is not properly aligned before `callq`, it must bw a multiple of 16
5H: The compiler is comparing %rax (return value) with %rdi. But there are no guarantees on what %rdi actually is after \_Z1gl is called
5I: It pushes to the stack but doesn't pop from the stack
5J: rdi and rsi are dereferenced, but they're not pointers
5K: `ja` is unsigned, but these are ints
5L: The addition updates flags

6A: cmpl %edi %esi; movl %edi %esi
6B: movq 0x18(%rax,%rbx,4),
6C: movl 4(%rdi, %rsi, 8), %eax
6D: movzbl (%rdi), %eax
6E: movq (%rdi), %rax; movl (%rcx), %rax
6F: cmpq %rdi, $1
6G: mulq %rdi, $2
6H: movq $10, %rax; ret
6I: movq $10, %rax; ret

###########

1E: 4(k + m)
1F: 0

5A: H
5B: D
5C: J

10: char a, int d, unsigned char b, short c
