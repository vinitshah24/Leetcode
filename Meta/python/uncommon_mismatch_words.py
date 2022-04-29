"""
Complete a function that returns a list containing mismatched words in two strings.
The return list can be in any order. w used set to solve this question,
but was also asked to verbally explain how w would solve it without using sets.
"""


def mismatch(word1, word2):
    all_words = word1 + word2
    res = []
    for w in set(all_words):
        # If not in both strings then append it to res
        if w in word1 and w in word2:
            continue
        else:
            res.append(w)
    return res


def mismatch(word1, word2):
    res = []
    for w in word1:
        if w not in word2:
            res.append(w)
    for j in word2:
        if j not in word1:
            res.append(j)
    return res


word1 = 'Hello'
word2 = 'HelloFriends'
print(mismatch(word1, word2))

# ------------------------------------------------------------------------------------

# Given two sentences, construct an array that has the words that appear in one sentence and not the other.
A = "Geeks for Geeks"
B = "Learning from Geeks for Geeks"
d = {}
for w in A.split():
    if w in d:
        d[w] = d.get(w, 0)+1
    else:
        d[w] = 1
for w in B.split():
    if w in d:
        d[w] = d.get(w, 0)+1
    else:
        d[w] = 1
unmatchedW = [w for w in d if d[w] == 1]
print(unmatchedW)
