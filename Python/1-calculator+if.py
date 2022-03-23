# Debilnuy calculator v1
what = input("What we do? (+, -): ")

a = float(input("Enter first number: "))
b = float(input("Enter second number: "))

if what == "+":
    c = a + b
    print("Result is " + str(c))
elif what == "-":
    c = a - b
    print("Result is " + str(c))
else:
    print("You dont make right choise")
