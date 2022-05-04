"""
Write a function that takes a number and returns a list of its digits
"""


# def solution(input):
#     res = []
#     res[:0] = str(input)
#     return res


def solution(input):
    res = []
    c = str(input)
    for i in range(len(c)):
        res.append(int(c[i]))
    return res


assert solution(123) == [1, 2, 3]
assert solution(400) == [4, 0, 0]
