# +, -, *, /, **, %, unarniy minus, okruglenie, chislo Pi
import math #import modula dlya okruglenia
y = 5
z = 10

a = y + z
b = y - z
c = y * z
d = y / z
e = y ** 2 #vozvedenie v stepen
f = z % 3 #delenie po modulu
y = -y #ynarniy minus
g = 5.65 #primer okruglenia

print(a)
print(b)
print(c)
print(d)
print(e)
print(f)
print(y)
print (round(g)) #primer okruglenia
print (math.floor(g)) #okruglenia v mensuyu storonu
print (math.ceil(g)) #okruglenia v bolsuyu storonu
print (math.pi) #vivod Pi chere module math
