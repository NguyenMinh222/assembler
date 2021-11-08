.model small
.stack 100h
.8086
.data
 N dw ?
 mess db 'Vvedite chislo N: $'
.code 
main:
mov ax, @data
mov ds,ax

mov ah, 09h
mov DX, offset mess
int 21h

call writenum
 mov cx, 2
 cmp bx,0
 ja cycle
 
 cycle:
 ;A=cx,N=bx 
 mov dx, 0
 cmp cx, bx
 ja print
 ;if N%A==0
 mov ax, bx
 div cx
 cmp dx,0
 jz ZERO1
 jmp NOTZERO
 
 NOTZERO:
 inc cx
 jmp cycle
  
 ZERO1:
mov ax, bx
div cx
mov bx, ax
 jmp cycle
 

print:
mov ax, cx
call printnum  
 
   
writenum:
mov bx,0
mov ah, 01h
int 21h
cmp al, 2dh

    je freq
    call analyze
    ret
    freq:
    call write
    not bx 
    inc bx
    ret
 write:
    mov ah, 01h
    int 21h
analyze:
    cmp al, 0dh
    je endl
    cmp al, 10
    je endl
    sub al, 48;
    mov ah, 0
    push ax
    mov ax, 10
    mul bx
    mov bx, ax
    pop ax
    add bx, ax
    call write
endl:
    ret    

    

printnum:
   
    cmp ax, 0
    jz pzero
    jnl printpos
    mov dl, '-'
    push ax
    mov ah, 02h
    int 21h
    pop ax
    not ax 
    inc ax
   
    
    printpos:
    cmp ax, 0
    jz zero
    mov dx, 0
    mov bx, 10
    div bx    
    add dl, 48
    push dx
    
    call printpos
    pop dx
    push ax
    mov ah, 02h
    int 21h
    pop ax
zero:
    ret
pzero:
    mov dl, 30h
    mov ah, 02h
    int 21h
    ret
    
end main 