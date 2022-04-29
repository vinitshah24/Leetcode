"""
Write a function to count the number of times each character appears in a string and rewrite the string in that format.
Ex. "I am back." should become "i1 2a2m1b1c1k1.1"
"""


def char_counts(my_str):
    d = {}
    for c in my_str:
        if c in d.keys():
            d[c] += 1
        else:
            d[c] = 1
    l = []
    for k, v in d.items():
        l.append(k)
        l.append(str(v))
    res = ''.join(l)
    return res


def number_times(s):
    chars = list(s)
    dCount = {}
    for c in chars:
        dCount[c] = dCount.get(c, 0) + 1
        string = ""
    for k, v in dCount.items():
        string += k+str(v)
    return string


my_str = "I am back."
print(char_counts(my_str))

inp_str = "I am back."
print(number_times(inp_str))
