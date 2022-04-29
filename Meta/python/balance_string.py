"""
Balance the string., i.e., How many additional literals needed to evenly balance the string.
String is made of a-j and 0-9 where alphabets marks the opening and numbers as closing.
For e.g., ab00a. This is unbalanced since it requires pair of b with 1, and additional 0 occurs before “a”
ie., missing opening pair and later “a” without its closing number pair. Result : 3
E.g., bj19 is balanced so result 0.
"""


def balance(word):
    ref = {
        '0': 'a',
        '1': 'b',
        '2': 'c',
        '3': 'd',
        '4': 'e',
        '5': 'f',
        '6': 'g',
        '7': 'h',
        '8': 'i',
        '9': 'j'
    }
    stack = []
    cnt = 0
    for i in word:
        if i in ref and ref[i] in stack:
            stack.pop(stack.index(ref[i]))
        elif i in ref and ref[i] not in stack:
            cnt += 1
        else:
            stack.append(i)
    return len(stack) + cnt


print(balance("ab00a"))
print(balance("bj19"))
