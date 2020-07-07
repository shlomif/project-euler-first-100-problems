#include <algorithm>
#include <cstring>
#include <iostream>
#include <queue>
unsigned const maxC = 10000;
struct tripleT
{
    unsigned a, b, c;
};
tripleT typeA(tripleT const &tp)
{
    tripleT tmp = {/**/ tp.a - 2 * tp.b + 2 * tp.c, 2 * tp.a - tp.b + 2 * tp.c,
        2 * tp.a - 2 * tp.b + 3 * tp.c};
    return tmp;
}
tripleT typeB(tripleT const &tp)
{
    tripleT tmp = {/**/ tp.a + 2 * tp.b + 2 * tp.c, 2 * tp.a + tp.b + 2 * tp.c,
        2 * tp.a + 2 * tp.b + 3 * tp.c};
    return tmp;
}
tripleT typeC(tripleT const &tp)
{
    tripleT tmp = {/**/ -tp.a + 2 * tp.b + 2 * tp.c,
        -2 * tp.a + tp.b + 2 * tp.c, -2 * tp.a + 2 * tp.b + 3 * tp.c};
    return tmp;
}

void reorder(tripleT &tp)
{
    if (tp.a > tp.b)
    {
        unsigned tmp = tp.a;
        tp.a = tp.b;
        tp.b = tmp;
    }
}

int main()
{
    tripleT tp = {3, 4, 5};
    std::vector<tripleT> triple;
    std::queue<tripleT> queue;
    queue.push(tp);
    while (!queue.empty())
    {
        tp = queue.front();
        queue.pop();
        if (tp.c > maxC)
            continue;
        triple.push_back(tp);
        queue.push(typeA(tp));
        queue.push(typeB(tp));
        queue.push(typeC(tp));
    }

    unsigned nPrinciplesTriples = triple.size();
    for (unsigned u = 0; u < nPrinciplesTriples; ++u)
    {
        tp = triple[u];
        for (unsigned v = 2;; ++v)
        {
            tripleT tmp = {tp.a * v, tp.b * v, tp.c * v};
            if (tmp.c > maxC)
                break;
            triple.push_back(tmp);
        }
    }
    for_each(triple.begin(), triple.end(), reorder);

    unsigned cache[maxC];
    memset(cache, 0, sizeof(unsigned) * maxC);
    for (unsigned u = 0; u < triple.size(); ++u)
    {
        unsigned lo = triple[u].a;
        unsigned hi = triple[u].b;
        int tmp = lo - (hi + 1) / 2 + 1;
        if (tmp > 0)
            cache[lo] += tmp;
        cache[hi] += lo / 2;
    }

    unsigned M;
    unsigned nSol = 0;
    for (M = 0; nSol < 1000000; ++M)
        nSol += cache[M];
    std::cout << "M = " << M - 1 << ", nSol = " << nSol << '\n';

    return 0;
}
