# Given an array of integers, determine whether the array is monotonic (non-decreasing/non-increasing) or not.
# Examples:
# 1 2 5 5 8    => true
# 9 4 4 2 2    => true
# 1 1 1 1 1 1  => true
# 1 4 6 3      => false

def is_monotonic(arr):
    return True if arr == sorted(arr) or arr == sorted(arr, reverse=True) else False

arr = [1, 2, 6, 5, 8]
print(arr, is_monotonic(arr))

def is_monotonic(arr):
    inc = dec = True
    for i in range(len(arr)-1):
        if arr[i] > arr[i+1]:
            inc = False
        if arr[i] < arr[i+1]:
            dec = False
    return inc or dec

arr = [1, 1, 1, 1, 1]
print(arr, is_monotonic(arr))
