# The query language is a very simple regular expression-like language, with one special character: . (the dot character),
# which means EXACTLY ONE character (it can be any character).
# So, for example, 'c.t' would match 'cat' as the dot matches any character.
# There may be any number of dot characters in the query (or none).

# Your spell checker will have to be optimized for speed, so you will have to write it in the required way.
# There would be a one-time setUp() function that does any pre-processing you require,
# and then there will be an is_match() function that should run as fast as possible, utilizing that pre-processing.

# There are some examples below, feel free to ask for clarification.
# Word List:
# [cat, bat, rat, drat, dart, drab]

# Queries:
# cat -> true
# c.t -> true
# .at -> true
# ..t -> true
# d..t -> true
# dr.. -> true
# ... -> true
# .... -> true

# ..... -> false
# h.t -> false
# c. -> false

# Write a function:
# Struct setup(List<String> list_of_words)
#     Do whatever processing you want here with reasonable efficiency.
#     Return whatever data structures you want.
# This function will only run once

# Write a function:
# bool is_match(Struct struct, String query)
#   Returns whether the query is a match in the dictionary (True/False)
# Should be optimized for speed

def setUp(word, input_list):
    word = word.strip()
    temp_list = []
    is_match = False
    if word in input_list:
        is_match = True
    elif word is None or len(word) == 0:
        is_match = False
    else:
        for w in input_list:
            if len(w) == len(word):
                temp_list.append(w)
        for j in range(len(temp_list)):
            count = 0
            for i in range(len(word)):
                if word[i] == temp_list[j][i] or word[i] == '.':
                    count += 1
                else:
                    break
            if count == len(word):
                is_match = True
    print(is_match)


def is_match(word, input_list):
    return setUp(word, input_list)


arr = ['cat', 'bte', 'art', 'drat', 'dart', 'drab']
is_match('c.t', arr)
is_match('.....', arr)
is_match('h.t', arr)


def is_matched(wrd, lst):
    if len(wrd) not in [len(x) for x in lst]:
        return False
    elif wrd in lst:
        return True
    else:
        lst1 = [x for x in lst if len(x) == len(wrd)]
        for z in lst1:
            c = 0
            for i in range(len(wrd)):
                if wrd[i] != '.' and wrd[i] == z[i]:
                    c = c+1
                    if len(wrd)-wrd.count('.') == c:
                        return True
    return False


arr = ['cat', 'bte', 'art', 'drat', 'dart', 'drab']
print(is_matched('c.t', arr))
print(is_matched('.....', arr))
print(is_matched('h.t', arr))
