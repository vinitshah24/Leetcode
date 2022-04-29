d = {"a": 4, "c": 3, "b": 12}
res = [(k, v) for k, v in sorted(d.items(), key=lambda x: x[1], reverse=True)]
#[('b', 12), ('a', 4), ('c', 3)]
print(res)
