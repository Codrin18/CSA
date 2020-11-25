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
    a db 1
    b db 3
    c db 5
    d db 7
    e dw 2
    x dq 10
    res dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
         ; a * b 
         mov al,[a]
         mov bl,[b]
         imul bl ; ax = a * b 
         
         ; 2 * c * d 
         mov bx,ax 
         mov ax,0
         mov al,2 
         imul byte[c] 
         imul byte[d] ; ax = 2 * c * d 
         
         ; (a*b - 2 * c * d )
         sub bx,ax 
         mov ax,bx 
         mov bx,0
         cwde ; eax = (a*b - 2 * c * d )
         ; (c-e) 
         
         mov ebx,eax 
         mov eax,0
         mov al,[c]
         cbw ; ax = c 
         mov dx, [e]
         sub ax,dx ; ax = c - e 
         
         ;(a*b - 2 * c * d )/(c-e)
         mov cx,ax 
         mov eax,ebx 
         push eax 
         pop ax 
         pop dx 
         idiv cx 
         
         ; x/a 
         mov cx,ax 
         mov ax,[a]
         cbw 
         cwde 
         mov ebx,eax 
         mov eax,0
         mov edx,0
         mov eax,dword[x+0]
         mov edx,dword[x+4]
         idiv ebx 
         
         ;(a*b-2*c*d)/(c-e)+x/a 
         mov edx,0
         mov edx,eax 
         mov eax,0
         mov ax,cx 
         cwde 
         
         add eax,edx 
         mov [res],eax ; res = (a*b-2*c*d)/(c-e)+x/a 
         
         
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
