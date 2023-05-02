#Collatz Conjecture

def collatz(n):
    l = [n]
    while True:
        if n==1:
            break
        elif n%2==0:
            n = n/2
        else:
            n = (3*n)+1
        l.append(n)
    print(l)
    print(len(l))

collatz(895453980)
