"""
Calculate the average word length. For the given set of word_arr return the average word length.
"""


def avg_len(word_arr):
    return len(''.join(word_arr)) / len(word_arr)


print(avg_len(["awesome", "fine", "ok"]))


def _average_world_length(word_arr):
    if not word_arr:
        return 0
    sum = 0
    for word in word_arr:
        if not word:
            continue
        sum += len(word)
    return float(sum/len(word_arr))


print(_average_world_length(["awesome", "fine", "ok"]))
print(_average_world_length(["awesome", "fine", "ok", "ok", "ok", "ok"]))
print(_average_world_length(["awesome", None, "ok"]))
print(_average_world_length(["awesome", "0", "ok"]))
print(_average_world_length(None))
