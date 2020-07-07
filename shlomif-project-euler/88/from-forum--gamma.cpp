#include <iostream>
unsigned const kLimit = 12000;
unsigned const k2 = kLimit * 2;
unsigned const kDiv2 = kLimit / 2;
unsigned cache[kLimit + 1];
unsigned sum;
bool solCache[k2 + 1];

int main()
{
    for (unsigned u = 0; u <= kLimit; ++u)
        cache[u] = 2 * u;

    for (unsigned a = 1; a <= kDiv2; ++a)
    {
        for (unsigned b = a; b <= kDiv2; ++b)
        {
            if (a * b > k2)
                break;
            for (unsigned c = b; c <= kDiv2; ++c)
            {
                if (a * b * c > k2)
                    break;
                for (unsigned d = c; d <= kDiv2; ++d)
                {
                    if (a * b * c * d > k2)
                        break;
                    for (unsigned e = d; e <= kDiv2; ++e)
                    {
                        if (a * b * c * d * e > k2)
                            break;
                        for (unsigned f = e; f <= kDiv2; ++f)
                        {
                            if (a * b * c * d * e * f > k2)
                                break;
                            for (unsigned g = f; g <= kDiv2; ++g)
                            {
                                if (a * b * c * d * e * f * g > k2)
                                    break;
                                for (unsigned h = g; h <= kDiv2; ++h)
                                {
                                    if (a * b * c * d * e * f * g * h > k2)
                                        break;
                                    for (unsigned i = h; i <= kDiv2; ++i)
                                    {
                                        if (a * b * c * d * e * f * g * h * i >
                                            k2)
                                            break;
                                        for (unsigned j = i; j <= kDiv2; ++j)
                                        {
                                            if (a * b * c * d * e * f * g * h *
                                                    i * j >
                                                k2)
                                                break;
                                            for (unsigned k = j; k <= kDiv2;
                                                 ++k)
                                            {
                                                if (a * b * c * d * e * f * g *
                                                        h * i * j * k >
                                                    k2)
                                                    break;
                                                for (unsigned l = k; l <= kDiv2;
                                                     ++l)
                                                {
                                                    if (a * b * c * d * e * f *
                                                            g * h * i * j * k *
                                                            l >
                                                        k2)
                                                        break;
                                                    for (register unsigned m =
                                                             l;
                                                         m <= kDiv2; ++m)
                                                    {
                                                        unsigned product =
                                                            a * b * c * d * e *
                                                            f * g * h * i * j *
                                                            k * l * m;
                                                        unsigned sum =
                                                            a + b + c + d + e +
                                                            f + g + h + i + j +
                                                            k + l + m;
                                                        unsigned kk =
                                                            13 +
                                                            (product - sum);
                                                        if (kk > kLimit)
                                                            break;
                                                        if (product < cache[kk])
                                                            cache[kk] = product;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    for (unsigned u = 2; u <= kLimit; ++u)
        solCache[cache[u]] = true;
    for (unsigned u = 2; u <= k2; ++u)
        if (solCache[u])
            sum += u;
    std::cout << "Sum: " << sum << "\n";
}
