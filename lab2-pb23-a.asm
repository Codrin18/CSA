bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
                          
                          ; [(a+b)*3-c*2]+d

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 1
    b db 3
    c db 5
    d dw 7
    res dw 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
         ;(a+b)*3
         mov al,[a]
         add al,[b]
         mov bl,al ; bl = (a+b)
         mov al,0
         mov al,3
         imul bl 
         mov bx,ax ; bx = (a+b)*3 
         ;c*2 
        
         mov ax,0
         mov al,2
         imul byte[c] ; ax = c * 2
         ;[(a+b)*3 - c*2]
         sub bx,ax
         
         ; [(a+b)*3 - c*2]+d 
         mov ax,bx 
         mov bx,0
         mov bx,[d]
         add ax,bx 
         mov [res],ax
         
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
