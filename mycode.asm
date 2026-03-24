
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h


; add your code here 
mov ax,0013h ;ekranin olusturulmasi
int 10h

mov cx,30d ;c topun x konumu, d topun y konumu
mov dx,30d ;simdilik

xdirval db 0 ;topun sol sag yonu
ydirval db 0 ;topun asagi yukari yonu
yspeed dw 0 ;topun y hizi
oldx dw 0 ;topun eski konumu
oldy dw 0 ;top her konumda silinip tekrar
newx dw 0 ;cizildiginden eski ve su anki
newy dw 0 ;konumun tutulmasi lazim

update:
mov ax, newx ;bir onceki updatedeki konum
mov oldx, ax ;eski konum degiskenine
mov ax, newy ;yukleniyor
mov oldy, ax 

mov al, dl ;y hizinin hesaplanmasi,
mov ah, 0 ;su anki y konumunun
mov bl, 5 ;istedigim bir degere bolunmesiyle
div bl ;elde ediliyor
mov ah, 0 ;boylece top yukari cikinca yavaslayip
mov yspeed, ax ; zemine yaklastikca hizlaniyor

cmp newx, 310d ;sag ve sol sinirlar
jg toleft ;sag sinir gecilirse top sola doner
cmp newx, 10d
jl toright ;tam tersi    
     
xdir:
cmp xdirval, 0 ;x yonunde hareket,su anki yon degerine gore hareket
jg xbig
je xsmall
   
   
xafter: ;x hareketi bitti (x konumu belirlendi daha dogrusu)

cmp newy, 190d ;ust ve asagi sinirlar
jg todown
cmp newy, 10d
jl toup

ydir: ;y yonunde hareket
cmp ydirval, 0
jg ybig
je ysmall

yafter: ;y hareketi bitti
 

mov cx, oldx ;silinecek eski top
mov dx, oldy
mov ax,0c00h ;siyaha cevirilerek silinir
int 10h ;ekran guncellenir 
mov cx, newx ;yeni top
mov dx, newy
mov ax,0c0ch ;kirmizi
int 10h ;ekran gunc.

 
jmp update ;update tekrar doner

toleft: ;sola donme
mov xdirval, 1 ;yeni yon
jmp xdir ;yeni yon belirlendikten sonra x hareket fonk.a gidilir
toright: ;saga donme
mov xdirval, 0
jmp xdir ;bir onceki fonk.un aynisi 
todown: ;asagi d.
mov ydirval, 1
jmp ydir ;Ayni
toup: ;yukari d.
mov ydirval, 0
jmp ydir ;ayni
xbig: ;isim alakasiz biraz ama x konumunun guncellenmesi
sub newx, 3 ;3 istedigim x hizi
jmp xafter ;x hareketi biter
xsmall:   ;aynisi
add newx, 3
jmp xafter
ybig:            ;aynisi y icin
mov ax, yspeed
sub newy, ax
jmp yafter
ysmall:                        ;bu da ayni
mov ax, yspeed
add newy, ax
jmp yafter

ret ;simdilik program hic bitmiyor



