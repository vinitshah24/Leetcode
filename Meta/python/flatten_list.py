"""
Flatten a list: [1, 2, [3, 4, [5], [6, 7, [8, [9]]]]]
"""


def flatten_list(arr, res=[]):
    for i in arr:
        if isinstance(i, list):
            flatten_list(i, res)
        else:
            res.append(i)
    return res


arr = [1, 2, [3, [4, [5]]]]
print(flatten_list(arr))
