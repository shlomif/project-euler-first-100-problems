'''
Taken from:
https://github.com/TheAlgorithms/Python/

    '''
from __future__ import print_function

from math import sqrt

from six.moves import range


def sum_of_divisors(n):
    total = 0
    for i in range(1, int(sqrt(n)+1)):
        if n % i == 0 and i != sqrt(n):
            total += i + n//i
        elif i == sqrt(n):
            total += i
    return total-n


total = [i for i in range(1, 10000) if
         sum_of_divisors(sum_of_divisors(i)) == i and sum_of_divisors(i) != i]
print(sum(total))
