#!/usr/bin/env python3

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

def upper(n):
    return int(str(n)[0:2])


def lower(n):
    return int(str(n)[2:4])


def is_len4(n):
    return ((n >= 1000) and (n <= 9999))


def _oct(n):
    return n * (3*n-2)


class Figurate:
    def get_m(self):
        return self.m

    def solve(self):
        # fill should be called first.
        n = 1
        while not is_len4(_oct(n)):
            n += 1
        r = False
        while not r:
            r = self.solve_for([_oct(n)], frozenset())
            n += 1
        return r

    def solve_for(self, nums, checked):
        if (len(checked) == len(self.m.keys())):
            return nums if (lower(nums[-1]) == upper(nums[0])) else False
        low = lower(nums[-1])
        for base in self.m.keys():
            if base in checked:
                continue
            new_checked = checked.union([base])
            d = self.m[base]['s']
            for n in (d[low] if low in d else []):
                ret = self.solve_for(
                    nums + [int(str(low) + str(n))],
                    new_checked
                )
                if ret:
                    return ret
        return False

    def fill(self):
        for base in self.m.keys():
            g = self.m[base]['g']
            n = 1
            while not is_len4(g(n)):
                n += 1
            while is_len4(g(n)):
                result = g(n)
                low = lower(result)
                u = upper(result)
                if u not in self.m[base]['s']:
                    self.m[base]['s'][u] = []
                self.m[base]['s'][u].append(low)
                n += 1

    def __init__(self):
        self.m = {
            3: {
                # g is the generator
                'g': (lambda n: ((n * (n+1)) >> 1)),
                # s are the steps
                's': {},
            },
            4: {
                'g': (lambda n: (n**2)),
                's': {},
            },
            5: {
                'g': (lambda n: ((n*(3*n-1)) >> 1)),
                's': {},
            },
            6: {
                'g': (lambda n: (n*(2*n-1))),
                's': {},
            },
            7: {
                'g': (lambda n: ((n*(5*n-3)) >> 1)),
                's': {},
            },
        }


def main():
    f = Figurate()
    f.fill()
    r = f.solve()
    print(sum(r))


main()
