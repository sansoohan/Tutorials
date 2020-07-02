
t1 = (1,3.14,"Sansoo")
print(len(t1))
print(t1[0])
print(t1[-1])

d1 = {
  "Superman": "Clark Kent",
  "Batman": "Bruce Wayne"
}

print(len(d1))
print(d1["Superman"])
d1["Flash"] = "Barry Allen"
print(d1)
print(list(d1.items()))
print(list(d1))
print(list(d1.keys()))
print(list(d1.values()))
d1.pop("Batman")
print(d1)

s1 = set(["Sansoo", 1])
s2 = {"Sansoo", 2}
s3 = s1 | s2
print(s3)

s3.add("Han")
s3.discard("Sansoo")
print(s3)
s3.pop()
print(s3)

print(s2.intersection(s3))
print(s2.symmetric_difference(s3))
print(s2.difference(s3))
s3.clear()
print(frozenset(["Han", "Sansoo"]))
print(frozenset(["Han", "Sansoo"]))
