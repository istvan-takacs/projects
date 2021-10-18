import random

def rand_list(n):
    array = [random.randint(1, n) for num in range(n)]
    return array

def insertion_sort(array):
    for i in range(1, len(array)):
        key = array[i]
        j = i-1

        while j >= 0 and array[j] > key:
            array[j+1] = array[j]
            j -= 1
        array[j+1] = key

    return array

print(insertion_sort(rand_list(5)))




