
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h


; add your code here
;degiskenler
xdirval db 0 ;topun sol sag yonu
ydirval db 0 ;topun asagi yukari yonu
yspeed dw 0 ;topun y hizi
oldx dw 0 ;topun eski konumu
oldy dw 0 ;top her konumda silinip tekrar
newx dw 0 ;cizildiginden eski ve su anki
newy dw 0 ;konumun tutulmasi lazim
ball db 00h,00h,0ch,0ch,0ch,00h,01h,0ch,0ch,0ch,0ch,0ch,02h,0ch,0ch,0ch,0ch,0ch,03h,0ch,0ch,0ch,0ch,0ch,04h,00h,0ch,0ch,0ch,00h ;ilk sayi baslangic y degeri,
;1,2 vs. sonraki y degeri diger c ve 0lar piksel renk degerleri
ind db 25 ;cizim fonk.da kullanilan indis
xdrawval dw 0 ;cizim fonk.da kullanilan koordinat degerleri
ydrawval dw 0 ;cizim fonk.da kullanilan koordinat degerleri

mov ax,0013h ;bu satir atlaniyor neden bilmiyorum 
mov ax,0013h ;ekranin olusturulmasi
int 10h

mov cx,30d ;c topun x konumu, d topun y konumu
mov dx,30d ;simdilik
;-------------------------------------------------
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
jmp draw
 
jmp update ;update tekrar doner
;--------------------------------------
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
;---------------------------------------
draw:
mov cx, 25 ;dongu adedi
drawloop:
mov ind, 25
sub ind, cl ;dizi elemani indisi

mov ah, 0
mov al, ind
add ax, 5
mov bx, 5
div bl
dec al

mov bh, 0 ;x ve y cizim konumlarinin olusturulmasinda ilk adim
mov bl, al
mov xdrawval, bx
mov bh, 0
mov bl, ah
mov ydrawval, bx

cmp ah,5 ; indis 0,5,10 vs degilse piksel cizimi yapilir cunku bu indislerdeki elemanlar piksel elemani degil
jg xdraw

xdraw:
mov bh, 0
mov bl, ind
mov al, ball[si+bx] ;top dizisinden deger alinir
mov bx, newx
add xdrawval, bx
mov bx, newy
add ydrawval, bx
mov cx, xdrawval
mov dx, ydrawval
mov ah,0ch ;kirmizi
int 10h ;ekran gunc.

mov ch, 0 ;dongu numarasinin restore edilmesi
mov cl, 25
sub cl, ind

loop drawloop
jmp update
;----------------------------------------
ret ;simdilik program hic bitmiyor



