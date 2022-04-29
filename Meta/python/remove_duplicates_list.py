""" Remove duplicates from a list """


def remove_duplicates(arr):
    op_dict = {}
    op_list = []
    for i in arr:
        if i not in op_dict.keys():
            op_dict[i] = 1
            op_list.append(i)
    return op_list


arr = [1, 1, 1, 2, 2]
print(remove_duplicates(arr))
