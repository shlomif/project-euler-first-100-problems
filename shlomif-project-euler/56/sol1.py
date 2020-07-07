"""
Based on:

https://github.com/TheAlgorithms/Python/blob/master/project_euler/problem_56/sol1.py

"""


def maximum_digital_sum(a: int, b: int) -> int:
    ret = 0
    for base in range(2, a):
        aa = base
        for power in range(1, b):
            ret = max(ret, sum([int(x) for x in str(aa)]))
            aa *= base
    return ret


# Tests
if __name__ == "__main__":
    print(maximum_digital_sum(100, 100))
