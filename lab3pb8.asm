bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 0111011110101011b
    b dw 1010101000110001b
    c db 10001001b
    d dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx, 0 ; we compute the result in ebx 
        mov eax, 0
        ; opertion 1: the bits 8-15 are the same as the bits of C
        mov ah, [c]
        or bh, ah ; ebx = 00000000 00000000 10001001 00000000
        ; operation 2: the bits 0-7 are the same as the bits 8-15 of B
        mov eax, 0 
        mov ax, [b]
        and ax, 1111111100000000b
        mov cl, 8
        ror ax,cl
        or bx, ax ; ebx = 00000000 00000000 10001001 10101010
        ; operation 3: the bits 24-31 are the same as the bits 0-7 of A
        mov eax, 0
        mov ax, [a]
        and ax, 0000000011111111b
        mov cl,24
        ror ebx, cl
        or ebx, eax
        rol ebx, cl
        ; operation 4 : the bits 16-23 are the same as the bits 8-15 of A
        mov eax,0
        mov ax,[a]
        and ax, 1111111100000000b
        mov cl, 8
        ror ebx, cl 
        or ebx, eax 
        rol ebx, cl
        mov [d], ebx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
