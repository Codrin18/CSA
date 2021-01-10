bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,gets,scanf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import gets msvcrt.dll   
import scanf msvcrt.dll                        ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s resb 20 
    S db 0
    format db '%s', 0
    formatcharacter db '%c', 0
    printformatcharacter db 'S=', 0 
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword s
        call [gets]
        add esp, 4*1
        
        push dword S
        push formatcharacter
        call [scanf]
        add esp, 4*2
        
        mov ecx, 20
        mov esi, 0
        
        repeta:
            mov al, [s+esi]
            cmp al, ' '
            je space
            jne notSpace
            space:
                mov bl, [S]
                mov [s+esi], bl
                inc esi
            jmp end_repeta
            notSpace:
                inc esi 
                
                end_repeta:
        loop repeta
        
        push dword s 
        push dword format
        call [printf]
        add esp, 4*2
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
