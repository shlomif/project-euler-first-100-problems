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

#include <stdio.h>
#include <math.h>
#include <string.h>

#define limit 1500000

char verdicts[limit+1];

int main(int argc, char * argv[])
{
    int hypotenuse_lim = (limit / 2);

    memset(verdicts, '\0', sizeof(verdicts));

    for (int hypotenuse_length=5
            ;
         hypotenuse_length < hypotenuse_lim
            ;
         hypotenuse_length++
         )
    {
        if (hypotenuse_length % 1000 == 0)
        {
            printf("%d\n", hypotenuse_length);
        }

        long long hypot_sq = hypotenuse_length;

        hypot_sq *= hypot_sq;

        int side1_lim = (hypotenuse_length / 2);

        for(int side1_len = 1 ; side1_len < side1_lim ; side1_len++)
        {
            long long side1_sq = side1_len;

            side1_sq *= side1_sq;

            double side2_len = sqrt(hypot_sq - side1_sq);

            int side2_len_i = (int)side2_len;

            if (side2_len == side2_len_i)
            {
                int sum = side2_len_i + side1_len + hypotenuse_length;

                if (sum <= limit)
                {
                    if (verdicts[sum] != 2)
                    {
                        verdicts[sum]++;
                    }
                }
            }
        }
    }

    int count = 0;

    for (int sum = 12 ; sum < limit ; sum++)
    {
        if (verdicts[sum] == 1)
        {
            count++;
        }
    }

    printf("Count = %d\n", count);
    return 0;
}
