
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h


; add your code here 
mov ax,0013h
int 10h

mov cx,30d
mov dx,30d

xdirval db 0
ydirval db 0
yspeed dw 0
oldx dw 0
oldy dw 0
newx dw 0
newy dw 0 

update:
mov ax, newx
mov oldx, ax
mov ax, newy
mov oldy, ax 

mov al, dl
mov ah, 0
mov bl, 5
div bl
mov ah, 0
mov yspeed, ax

cmp newx, 90d
jg toleft
cmp newx, 15d
jl toright    
     
xdir:
cmp xdirval, 0
jg xbig
je xsmall
   
   
xafter:

cmp newy, 60d
jg todown
cmp newy, 10d
jl toup

ydir:
cmp ydirval, 0
jg ybig
je ysmall

yafter:
 

mov cx, oldx
mov dx, oldy
mov ax,0c00h
int 10h 
mov cx, newx
mov dx, newy
mov ax,0c0ch
int 10h

 
jmp update

toleft:
mov xdirval, 1
jmp xdir
toright:
mov xdirval, 0
jmp xdir 
todown:
mov ydirval, 1
jmp ydir
toup:
mov ydirval, 0
jmp ydir
xbig:
sub newx, 3
jmp xafter
xsmall:
add newx, 3
jmp xafter
ybig:
mov ax, yspeed
sub newy, ax
jmp yafter
ysmall:
mov ax, yspeed
add newy, ax
jmp yafter

ret



