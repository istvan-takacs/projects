import random


def rand_list(n):
    array = [random.randint(1, n) for num in range(n)]
    return array

def bubblesort(random_list):
    length = len(random_list) - 1
    for i in range(length):
        flag = 0
        for num in range(length-i):
            if random_list[num] > random_list[num + 1]:
                random_list[num], random_list[num + 1] = random_list[num + 1], random_list[num]
                flag = 1
        if flag == 0:
            break
    return random_list

print(bubblesort(rand_list(1000)))


