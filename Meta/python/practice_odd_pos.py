"""
Write a function that returns the elements on odd positions (0 based) in a list
"""


def solution(input):
    res = []
    for i in range(len(input)):
        if i % 2 == 1:
            res.append(input[i])
    return res


assert solution([0, 1, 2, 3, 4, 5]) == [1, 3, 5]
assert solution([1, -1, 2, -2]) == [-1, -2]
