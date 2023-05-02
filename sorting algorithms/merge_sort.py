import random

def rand_list(n, m=1000):
    array = [random.randint(1, m) for num in range(n)]
    return array

def merge_sort(array):
    if len(array) > 1:
        #grabbing the two halves of the list
        mid = len(array) // 2

        first_half = array[:mid]
        second_half = array[mid:]
        #recursively going through both halves
        merge_sort(first_half)
        merge_sort(second_half)

        #introducing iterators i and j for indexes and k for traversing through the array
        i = 0 #traversing first half
        j = 0 #traversing second half
        k = 0

        #while the indexes are smaller the lenghts of subarrays
        #replace array one by one
        while i < len(first_half) and j < len(second_half):
            #the value from the first half is smaller so use that
            if first_half[i] <= second_half[j]:
                array[k] = first_half[i]
                i += 1
            else:
                array[k] = second_half[j]
                j += 1
            k += 1
        # some might not be added by the above while loop
        while i < len(first_half):
            array[k] = first_half[i]
            i += 1
            k += 1
        while j < len(second_half):
            array[k] = second_half[j]
            j += 1
            k += 1


array = rand_list(100)
print(array)
merge_sort(array)
print(array)


















