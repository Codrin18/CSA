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
    s dd 10d,20d,30d,40d,50d
    l equ ($-s)/4 
    d times (l*2) dw 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        lea esi,[s] ; original array offset
        lea edi,[d] ; destination array offset
        mov ecx,l ; length of original array
        
        repeta:
            mov ax,[esi]
            inc esi
            mov [edi], ax
            inc edi
        loop repeta
        
        lea esi, [d]
        mov edi, l*2
        mov ecx,0
        mov ecx,l*2
        shr ecx, 1
        reverseLoop:
            mov ax, [esi]
            mov bx, [d+edi]
            mov [d+edi], ax
            mov [esi], bx
            add esi, 2
            add edi, 2
        loop reverseLoop
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
