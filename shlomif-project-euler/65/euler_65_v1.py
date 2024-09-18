# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

from fractions import Fraction


def digit_sum(n):
    return sum(int(digit) for digit in "{}".format(n))


def e_convergent(n):
    if n == 0:
        return 2
    elif n % 3 == 2:
        return ((Fraction(n-2, 3)+1)*2)
    else:
        return 1


def main():
    times = 100
    result = Fraction(e_convergent(times-1))  # .quo(1)
    for i in range(times-2, -1, -1):
        result = e_convergent(i) + 1 / result
    print("{}".format(digit_sum(result.numerator)))


main()
