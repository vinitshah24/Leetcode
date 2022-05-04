"""
From: http://codingbat.com/prob/p126968
Return the "centered" average of an array of ints, which we'll say is
the mean average of the values, except ignoring the largest and smallest values in the array.
If there are multiple copies of the smallest value, ignore just one copy, and likewise for the largest value.
Use int division to produce the final average. You may assume that the array is length 3 or more.
"""


def median(input):
    pos = (len(input)) // 2
    # FOR ODD
    if len(input) % 2 == 1:
        return input[pos]
    # FOR EVEN
    else:
        return input[pos] + input[pos + 1]

print(median([1, 2, 3, 4, 100]))
print(median([-10, -4, -2, -4, -2, 0]))


def centered_average(arr):
    return (sum(arr) - max(arr) - min(arr)) / (len(arr) - 2)

assert centered_average([1, 2, 3, 4, 100]) == 3
assert centered_average([1, 1, 5, 5, 10, 8, 7]) == 5
assert centered_average([-10, -4, -2, -4, -2, 0]) == -3
