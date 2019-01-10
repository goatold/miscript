#!/bin/env python

"""
from natural number sequence of 1 to n,
remove all multiples of 2, 3 and 5
what is the summation of all left numbers?
"""

n = 2017
k = (1, 2, 3, 5, 2*3, 2*5, 3*5, 2*3*5)
s = {i:0 for i in k}
sc = s.copy()

# sum of Arithmetic Series of multiples of (1, 2, 3, 5 ...)
for i in k:
    j = n/i
    sc[i] = (((1+j)*j)/2)*i

# calculation of sum numbers to be removed: total - intersaction of double duplicates + intersaction of triple duplication
print(sc, sc[1] - (sc[2]+sc[3]+sc[5]) + (sc[6]+sc[10]+sc[15]) - sc[30])

# traverse 1 to n and accumulate multiples of (1, 2, 3, 5 ...)
sn = 0
for i in range(n+1):
    # numbers who is NOT multiple of 2, 3 or 5
    if (i%2 != 0 and i%3 != 0 and i%5 != 0):
        sn += i
    for j in k:
        # numbers who is multiple of k
        if (i%j == 0):
            s[j] += i

print(s, sn)

