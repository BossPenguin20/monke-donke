import os

os.system("cls")

# lese inn data
print("  ===========")
print("||Første Tall||")
print("  ===========")
string1 = input("kan du skrive et tall fra 1 til 10?\n")
tall1 = int(string1)

# sjekk om tall1 er mellom 1 og 10
while ( ( tall1 > 10 ) or ( tall1 < 1 ) )            :
    print("tallet er ikke mellom 1 og 10\n") 

     # Ny sjanse    
    string1 = input("kan du skrive et til tall mellom 1 og 10?\n")
    tall1 = int(string1)


# lese inn data
print("  ==========")
print("||Andre Tall||")
print("  ==========")
string2 = input("kan du skrive et til tall mellom 1 og 10?\n")
tall2 = int(string2)

# sjekk om tall1 er mellom 1 og 10
while ( ( tall2 > 10 ) or ( tall2 < 1 ) ):
    print("tallet er ikke mellom 1 og 10\n") 
    
    # Ny sjanse    
    string2 = input("kan du skrive et til tall mellom 1 og 10?\n")
    tall2 = int(string2)   


# ingen ting


# skrive ut data
print("summen av tallene er ")
print(tall1 + tall2)

# vent på line feed
input()

os.system("cls")