section .bss
    input resb 256

section .text
    global _start

_start:
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 256
    int 0x80

    mov byte [input + eax - 1], 0

    mov esi, input
toggle_case:
    mov al, [esi]
    test al, al
    jz print_output

    cmp al, 'a'
    jl check_uppercase
    cmp al, 'z'
    jg check_uppercase
    sub al, 32
    jmp store_char

check_uppercase:
    cmp al, 'A'
    jl store_char
    cmp al, 'Z'
    jg store_char
    add al, 32

store_char:
    mov [esi], al
    inc esi
    jmp toggle_case

print_output:
    mov eax, 4
    mov ebx, 1
    mov edx, esi
    sub edx, input
    mov ecx, input
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

