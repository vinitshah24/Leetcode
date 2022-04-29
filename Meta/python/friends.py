# Given a two dimensional list for example [[2,3],[3,4],[5]] person 2 is friends with 3 etc.
# Find how many friends does each person has. note one person has no friends.

def get_friends_count(friends_arr):
    friend_dict = {}
    for arr in friends_arr:
        if len(arr) == 1:
            if arr[0] not in friend_dict:
                friend_dict[arr[0]] = 0
        else:
            if arr[0] in friend_dict:
                friend_dict[arr[0]] += 1
            else:
                friend_dict[arr[0]] = 1
            if arr[1] in friend_dict:
                friend_dict[arr[1]] += 1
            else:
                friend_dict[arr[1]] = 1
    return friend_dict


print(get_friends_count([[2, 3], [3, 4], [5]]))
