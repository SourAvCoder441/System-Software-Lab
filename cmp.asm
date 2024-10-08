section .data
    prompt1 db 'Enter the first string: ', 0
    prompt1_len equ $ - prompt1
    prompt2 db 'Enter the second string: ', 0
    prompt2_len equ $ - prompt2
    msg1 db 'Strings are equal', 0xa
    msg1_len equ $ - msg1
    msg2 db 'Strings not equal', 0xa
    msg2_len equ $ - msg2
    result db 40 dup(0)

section .bss
    str1 resb 20
    str2 resb 20

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    lea ecx, [prompt1]
    mov edx, prompt1_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    lea ecx, [str1]
    mov edx, 20
    int 0x80
    mov byte [str1+eax-1], 0

    mov eax, 4
    mov ebx, 1
    lea ecx, [prompt2]
    mov edx, prompt2_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    lea ecx, [str2]
    mov edx, 20
    int 0x80
    mov byte [str2+eax-1], 0

    lea esi, [str1]
    lea edi, [str2]

cmp:
    mov al, [esi]
    mov bl, [edi]
    cmp al, bl
    jne not_equ
    inc esi
    inc edi
    test al, al
    jz end_cmp
    test bl, bl
    jz not_equ
    jmp cmp

end_cmp:
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg1]
    mov edx, msg1_len
    int 0x80
    jmp exit

not_equ:
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg2]
    mov edx, msg2_len
    int 0x80

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

