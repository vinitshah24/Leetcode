"""
Given an array containing None values, fill in the array with the most recent None value.
If the list starts with None, then don't do anything to it.
"""


def fill_na(arr):
    x1 = ""
    # Replace all None's with value before first None occurrence
    for x in range(1, len(arr)):
        if arr[x] is None:
            x1 = arr[x-1]
            break
    for x in range(1, len(arr)):
        if arr[x] is None:
            arr[x] = x1
    return arr


arr = ["A", None, "B", None, "D", None, None]
print(fill_na(arr))


# ---------------------------------------------------------------
# [1,None,1,2,None} --> [1,1,1,2,2]
# arr = [None, 1, 2, None]

arr = [1, None, 1, 2, None]
new_l = []
for i in range(len(arr)):
    if arr[i] != None:
        new_l.append(arr[i])
    else:
        new_l.append(arr[i-1])
print(new_l)
