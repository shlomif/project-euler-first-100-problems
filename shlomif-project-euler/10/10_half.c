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
int8_t bitmask[(limit+1)/8/2];

int main(int argc, char * argv[])
{
    int half, p, i;
    int half_limit;
    int loop_to;
    long long sum = 0 + 2;

    memset(bitmask, '\0', sizeof(bitmask));

    loop_to=(((int)(sqrt(limit)))>>1);
    half_limit = (limit-1)>>1;

    for (half=1 ; half <= loop_to ; half++)
    {
        if (! ( bitmask[half>>3]&(1 << (half&(8-1))) ) )
        {
            /* It is a prime. */
            p = (half << 1)+1;
            sum += p;
            for (i = ((p*p)>>1) ; i < half_limit ; i+=p )
            {
                bitmask[i>>3] |= (1 << (i&(8-1)));
            }
        }
    }

    for( ; half < half_limit ; half++)
    {
        if (! ( bitmask[half>>3]&(1 << (half&(8-1))) ) )
        {
            sum += (half<<1)+1;
        }
    }

    printf("%lli\n", sum);

    return 0;
}

