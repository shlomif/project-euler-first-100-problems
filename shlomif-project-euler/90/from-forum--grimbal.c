#include <stdio.h>

#define BIT(n) (1 << (n))

unsigned long bitCount(unsigned long n)
{
    n -= (n & 0xAAAAAAAA) >> 1;
    n = (n >> 2 & 0x33333333) + (n & 0x33333333);
    n = (n + (n >> 4)) & 0x0f0f0f0f;
    n = (n + (n >> 8));
    n = (n + (n >> 16)) & 0x000000ff;
    return n;
}

#define check(i, j) (a & BIT(i) && b & BIT(j) || b & BIT(i) && a & BIT(j))

int main()
{
    int a, b;
    int count = 0;
    for (a = 0; a < BIT(10); a++)
        if (bitCount(a) == 6)
            for (b = a; b < BIT(10); b++)
                if (bitCount(b) == 6)
                {
                    if (!check(0, 1))
                        continue;
                    if (!check(0, 4))
                        continue;
                    if (!check(0, 9) && !check(0, 6))
                        continue;
                    if (!check(1, 6) && !check(1, 9))
                        continue;
                    if (!check(2, 5))
                        continue;
                    if (!check(3, 6) && !check(3, 9))
                        continue;
                    if (!check(4, 9) && !check(4, 6))
                        continue;
                    if (!check(6, 4) && !check(9, 4))
                        continue;
                    if (!check(8, 1))
                        continue;
                    count++;
                }
    printf("count: %d\n", count);
    return 0;
}
