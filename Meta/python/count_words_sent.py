""" Count words in a sentence """

import collections


def count_unq_words(sentence):
    sentence = sentence.lower()
    arr = sentence.split()
    words_dict = collections.Counter(arr)
    print(len(words_dict))


sentence = "Count count words in a sentence"
count_unq_words(sentence)
