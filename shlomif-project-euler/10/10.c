// The Expat License
//
// Copyright (c) 2017, Shlomi Fish
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#include <string.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>

#define limit 2000000
int8_t bitmask[(limit+1)/8];

int main(int argc, char * argv[])
{
    int p, i;
    int mark_limit;
    long long sum = 0;

    memset(bitmask, '\0', sizeof(bitmask));
    mark_limit = (int)sqrt(limit);

    for (p=2 ; p <= mark_limit ; p++)
    {
        if (! ( bitmask[p>>3]&(1 << (p&(8-1))) ) )
        {
            /* It is a prime. */
            sum += p;
            for (i=p*p;i<=limit;i+=p)
            {
                bitmask[i>>3] |= (1 << (i&(8-1)));
            }
        }
    }
    for (; p <= limit; p++)
    {
        if (! ( bitmask[p>>3]&(1 << (p&(8-1))) ) )
        {
            sum += p;
        }
    }

    printf("%lli\n", sum);

    return 0;
}
