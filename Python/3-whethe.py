import pyowm
owm = pyowm.OWM('')
mgr = owm.weather_manager()
plase = input("where you living? ")
observation = mgr.weather_at_place(plase)
w = observation.weather
temp = w.temperature('celsius')['temp']

if temp < 10:
    print('Temperature is ' + str(temp) + ', very cold today')
elif temp > 10:
    print('Temperature is ' + str(temp) + ', not so cold today')
else:
    print('Temperature is ' + str(temp) + ', today ois hot')
