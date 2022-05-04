"""
Write a function that returns the cumulative sum of elements in a list
"""


def solution(input):
    output = [input[0]]
    for i in range(1, len(input)):
        output.append(output[i-1] + input[i])
    return output


assert solution([1, 1, 1]) == [1, 2, 3]
assert solution([1, -1, 3]) == [1, 0, 3]
