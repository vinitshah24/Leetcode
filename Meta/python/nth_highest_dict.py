"""
Given a dictionary, print the key for nth highest value present in the dict.
If there are more than 1 record present for nth highest value then sort the key and print first one (alphabetically)
N can be higher than the number of elements in the dictionary.
"""

d = {
    'a': 5,
    'b': 4,
    'c': 3,
    'd': 3,
    'e': 200,
    'f': 3
}
sorted_keys_res = sorted(list(set(d.values())))
print(sorted_keys_res)
