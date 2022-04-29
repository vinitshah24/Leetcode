"""
Write a function to return the number of times a character appears in a string. The character can be the empty string.
"""


def find_char_count(word):
    word_dict = {}
    for c in word:
        if c in word_dict:
            word_dict[c] += 1
        else:
            word_dict[c] = 1
    return word_dict


word = "abcadbccca"
print(find_char_count(word))
