bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    result dd 0
    format1 db 'Insert a value for a=', 0
    format2 db 'Insert a value for b=', 0
    readformat db '%d', 0
    printformat db '%d + %d = %x', 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword format1
        call [printf]
        add esp, 4*1
        
        push dword a 
        push dword readformat
        call [scanf]
        add esp, 4*2
        
        push dword format2
        call [printf]
        add esp, 4*1
        
        push dword b 
        push dword readformat
        call [scanf]
        add esp, 4*2 
        
        mov eax, [a]
        add eax, [b]
        mov [result], eax
        
        push dword [result]
        push dword [b]
        push dword [a]
        push dword printformat
        call [printf]
        add esp, 4*4
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
