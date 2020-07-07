from math import sqrt

from six.moves import range


def pent(x):
    return x*(3*x-1)/2


def is_pent(x):
    f = (.5 + sqrt(.25+6*x))/3
    if f - int(f) == 0:
        return True
    else:
        return False


flag = False
for i in range(1, 3000):
    if i % 100 == 0:
        print('i = %d' % (i))
    for j in range(i+1, 3000):
        if is_pent(pent(j) - pent(i)) and is_pent(pent(j) + pent(i)):
            print('answer = %d' % (pent(j) - pent(i)))
            flag = True
            break
    if flag:
        break
