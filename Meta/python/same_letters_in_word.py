""" Find 's' in mississippi """
string = 'mississippi'

x = 0
for i in range(len(string)):
    if string[i] == 's':
        x += 1
print(x)
