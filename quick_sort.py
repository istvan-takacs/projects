import random

def rand_list(n, m=1000):
    array = [random.randint(1, m) for num in range(n)]
    return array

def quick_sort(array):
    if len(array) < 2:
        return array
    else:
        low, selected, high = [], [], []
        pivot = array[random.randint(1, len(array)-1)]

        for item in array:
            if item < pivot:
                low.append(item)
            elif item == pivot:
                selected.append(item)
            elif item > pivot:
                high.append(item)
    return quick_sort(low) + selected + quick_sort(high)

print(quick_sort(rand_list(10)))