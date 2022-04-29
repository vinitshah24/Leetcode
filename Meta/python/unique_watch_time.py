"""
given a list of tuples of movie watched times, find how many unique minutes of the movie did the viewer watch
EXAMPLE: [(0,15),(10,25)].
The viewer watched 25 minutes of the movie.
"""


def getTotal(t):
    total = 0
    start = 0
    end = 0
    t = sorted(t)
    for i in t:
        # No Overlap
        if i[0] >= end:
            total = total + (i[1] - i[0])
        # Overlap
        else:
            minval = min(start, end, i[0], i[1])
            maxval = max(start, end, i[0], i[1])
            total = total + (maxval - minval) - (end-start)
            start = i[0]
            end = i[1]
    return total


t = [(0, 10), (15, 25), (12, 20), (30, 48)]
print(t, getTotal(t))

t = [(0, 15), (10, 25)]
print(t, getTotal(t))


def unique(input):
    totaladd = input[0][1] - input[0][0]
    totalsub = 0
    for i in range(1, len(input)):
        totaladd = totaladd + (input[i][1] - input[i][0])
        if input[i][0] < input[i-1][1]:
            totalsub = abs(input[i][0] - input[i-1][1])
    return totaladd - totalsub


t = [(0, 10), (15, 25), (12, 20), (30, 48)]
print(t, unique(t))

input = [(0, 15), (10, 25)]
print(t, unique(t))

input = [(0, 9), (0, 10), (1, 9)]
print(t, unique(t))
