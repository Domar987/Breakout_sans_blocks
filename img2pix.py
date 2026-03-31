from PIL import Image

palim=Image.open("egapalette.png")
palet=[]
bytestr=""
for y in range(0,4):
    for x in range(0,4):
        palet.append(palim.getpixel((x,y)))
#print(palet)

# resim dosyasının yolunu aşağı girin:
im=Image.open("title.png")

for y in range(0,im.size[1]):
    for x in range(0,im.size[0]):
        pixel=im.getpixel((x,y))
        istrans=True
        for i in range(0,16):
            #tmp = palet[i][1]
            #tmp = tmp[:-1]
            #print()
            #print(palet[i][1])
            #print(tmp)
            #print(pixel)
            if tuple(palet[i])==pixel[:-1]:
                istrans=False
                bytestr+=hex(i)
                bytestr+="h,"
        if istrans:
            bytestr+="0x10h,"

bytestr=bytestr[:-1]
print(bytestr)

input()
