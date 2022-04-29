"""
Don't use Regex so I did this by splitting the IP Address string at each '.' and then processing each of the sub-strings
"""


def check_ip(ip):
    l = ip.split('.')
    if len(l) != 4:
        return False
    for item in l:
        try:
            val = int(item)
            if val < 0 or val > 255:
                return False
        except ValueError:
            return False
    return True


print(check_ip("172.16.254.1"))
