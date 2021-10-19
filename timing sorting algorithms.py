from quick_sort import *
from merge_sort import merge_sort
from insert_sort import insert_sort
from bubble_sort import bubble_sort
import time

start = time.time()
for i in range(10000):
    quick_sort(rand_list(100))
end = time.time()
print(f"quick sort: {end-start}")

start = time.time()
for i in range(10000):
    merge_sort(rand_list(100))
end = time.time()
print(f"merge sort: {end-start}")

start = time.time()
for i in range(10000):
    insert_sort(rand_list(100))
end = time.time()
print(f"insert sort: {end-start}")

start = time.time()
for i in range(10000):
    bubble_sort(rand_list(100))
end = time.time()
print(f"bubble sort: {end-start}")
