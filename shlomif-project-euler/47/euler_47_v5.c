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

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define SIZE_CACHE 315730
uint8_t Cache[SIZE_CACHE];

void mark(const unsigned p)
{
    unsigned n = p;
    while (n < SIZE_CACHE)
    {
        if (Cache[n] < 5)
        {
            ++Cache[n];
        }
        n += p;
    }
}

int main()
{
    memset(Cache, '\0', sizeof(Cache));

    for (unsigned check = 2; check < 315720; ++check)
    {
        if (Cache[check] == 0)
        {
            mark(check);
            continue;
        }
        bool found = true;
        for (unsigned n = check; n < check + 4; n++)
        {
            if (Cache[n] != 4)
            {
                found = false;
                break;
            }
        }
        if (found)
        {
            printf("Found %d\n", check);
            break;
        }
    }

    return 0;
}
