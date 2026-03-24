
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
update:
mov ax,0c00h
int 10h

cmp cx, 90d
jg toleft
cmp cx, 15d
jl toright

xdir:
cmp xdirval, 0
jg xbig
je xsmall

xafter:

cmp dx, 60d
jg todown
cmp dx, 10d
jl toup

ydir:
cmp ydirval, 0
jg ybig
je ysmall

yafter:

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
dec cx
jmp xafter
xsmall:
inc cx
jmp xafter
ybig:
dec dx
jmp yafter
ysmall:
inc dx
jmp yafter

ret



