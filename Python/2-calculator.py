# Debilnuy calculator v1
from colorama import Fore, Back, Style, init

print(Fore.BLACK)
print(Back.GREEN)

what = input("What we do? (+, -): ")

print(Back.CYAN)

a = float(input("Enter first number: "))
b = float(input("Enter second number: "))

print(Back.YELLOW)

if what == "+":
    c = a + b
    print("Result is " + str(c))
elif what == "-":
    c = a - b
    print("Result is " + str(c))
else:
    print("You dont make right choise")
