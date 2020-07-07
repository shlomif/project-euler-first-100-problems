# -*- coding: utf-8 -*-
# Taken from https://github.com/TheAlgorithms/Python
# under MITL, thanks.
'''
Problem:
The sum of the squares of the first ten natural numbers is,
            1^2 + 2^2 + ... + 10^2 = 385
The square of the sum of the first ten natural numbers is,
            (1 + 2 + ... + 10)^2 = 552 = 3025
Hence the difference between the sum of the squares of the first ten natural
numbers and the square of the sum is 3025 − 385 = 2640.
Find the difference between the sum of the squares of the first N natural
numbers and the square of the sum.
'''


def e6(n):
    suma = (n*(n+1)) >> 1
    sumb = n*(n+1)*(2*n+1)//6
    return suma*suma - sumb


print(e6(100))
