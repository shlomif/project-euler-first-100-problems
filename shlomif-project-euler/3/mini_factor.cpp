/*
MIT/Expat License

Copyright (c) 2017 Oğuz Ertan Ayanlar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#include <cmath>
#include <iostream>

int main(int argc, char * argv[])
{
    if (argc < 2)
    {
        std::cerr << "You must supply a numeric argument!" << std::endl;
        return -1;
    }
    for (int i = 1; i < argc; ++i)
    {
        long long number = std::stoll(argv[i]);
        if (number < 0)
        {
            std::cerr << "The argument must be non-negative!" << std::endl;
            return -1;
        }
        std::cout << number << ':';
        long long limit = 1 + sqrtl(number);
        for (long long i = 2; i <= limit; ++i)
        {
            bool entered = false;
            while (number % i == 0)
            {
                entered = true;
                number /= i;
                std::cout << ' ' << i;
            }
            if (entered)
            {
                limit = 1 + sqrtl(number);
            }
        }
        if (number > 1)
        {
            std::cout << ' ' << number;
        }
        std::cout << std::endl;
    }
    return 0;
}
