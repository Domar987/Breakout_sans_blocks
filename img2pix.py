from PIL import Image
palim = Image.open("egapalette.png")
palet = palim.getcolors()
bytestr = ""
#print (palet)

#resim dosyasının yolunu aşağı girin:
im = Image.open("title.png")


for x in range(0,im.size[0]):
 for y in range(0,im.size[1]):
  pixel = im.getpixel((x,y))
  istrans=True
  for i in range(0, 16):
   #tmp = palet[i][1]
   #tmp = tmp[:-1]
   #print()
   #print(palet[i][1])
   #print(tmp)
   #print(pixel)
   if tuple(palet[i][1]) == pixel[:-1]:
    istrans=False
    bytestr += hex(i)
    bytestr += "h,"
   if istrans:
    bytestr += "0x10h,"

bytestr = bytestr[:-1]
print(bytestr)

input("entera basıp çıkın")