section .bss
    input resb 100    ; Reserve 100 bytes for the input string
    reversed resb 100 ; Reserve 100 bytes for the reversed string

section .data
    msg_prompt db 'Enter a string: ', 0
    msg_reversed db 'Reversed string: ', 0

section .text
    global _start

_start:
    ; Print prompt for the input string
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_prompt
    mov edx, 17
    int 0x80

    ; Read the input string from the user
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 100
    int 0x80

    ; Store the length of the input string
    mov byte [input + eax - 1], 0  ; Null-terminate the input string
    mov ecx, eax                  ; Save the length of the input string
    dec ecx                       ; Adjust length to exclude the newline character

    ; Set up pointers for reversing the string
    mov esi, input
    mov edi, reversed
    add esi, ecx
    dec esi

reverse_loop:
    mov al, [esi]
    mov [edi], al
    dec esi
    inc edi
    loop reverse_loop

    ; Null-terminate the reversed string
    mov byte [edi], 0

    ; Print the reversed string prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_reversed
    mov edx, 18
    int 0x80

    ; Print the reversed string
    mov eax, 4
    mov ebx, 1
    mov ecx, reversed
    mov edx, edi
    sub edx, reversed
    int 0x80

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

