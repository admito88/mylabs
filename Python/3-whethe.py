import pyowm
owm = pyowm.OWM('bdbbedf19c7ad58c54a029d3da00b09b')
mgr = owm.weather_manager()
plase = input("where you living? ")
observation = mgr.weather_at_place(plase)
w = observation.weather
print(w)
