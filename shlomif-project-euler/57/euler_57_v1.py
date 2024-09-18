# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php
#


from fractions import Fraction


def digit_sum(n):
    return sum([int(digit) for digit in "{}".format(n)])


def num_digits(n):
    return len("{}".format(n))


def numerator_with_more_digits(frac):
    return num_digits(frac.numerator) > num_digits(frac.denominator)


def calc_digits_sum(n):
    return sum(int(x) for x in str(n))


def sqrt2_next(frac):
    return 1 + 1/(1 + frac)


num = Fraction(3, 2)
count = 0
for i in range(1, 1000+1):
    if numerator_with_more_digits(num):
        count += 1
    num = sqrt2_next(num)

print("count = {}".format(count))
