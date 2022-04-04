print ( 10 == 10 )  # Дорівнює
print ( 10 != 11 )  # Не дорівнює
print ( 10 > 5 )  # Більше чи менше
print ( 5 >= 5 )  # Більше чи дорівнює
print ( "Test" > "Tesa" ) # Порівняння по стринг, номер букви в алфавіти указує на її вагу


pogoda = 'Rain'
time = 'Night'

if pogoda == 'Rain' and time == 'Night':
    print('all tasks is done')

if pogoda == 'Rain' and ( time == 'Night' or time == 'Day'):
    print('all work as always')
