"""
Given a list of ints, balance the list so that each int appears equally in the list.
Return a dictionary where the key is the int and the value is the count needed to balance the list.
[1, 1, 2] => {2: 1}
[1, 1, 1, 5, 3, 2, 2] => {5: 2, 3: 2, 2: 1}
input = [1, 1, 2]
"""

import collections

input = [1, 1, 1, 5, 3, 2, 2]
count_dict = dict(collections.Counter(input))
counts = list(count_dict.values())
max_count = max(counts)
res_dict = {}
for key, count in count_dict.items():
    if count < max_count:
        res_dict[key] = max_count - count
print(res_dict)
