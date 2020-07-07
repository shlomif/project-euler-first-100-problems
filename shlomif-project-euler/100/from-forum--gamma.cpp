#include <cmath>
#include <iostream>
int main()
{
    for (int n = 0;; ++n)
    {
        long long nBlue = (long long)ceill(
            sqrtl(floorl(powl(sqrtl(2.0) + 1, 4 * n + 2) / 32)));
        long long nDiscs = (long long)ceill(sqrtl(2.0 * nBlue * (nBlue - 1.0)));
        // std::cout<<nBlue<<" "<<nDiscs<<"\n";

        if (nDiscs > 1000000000000LL)
        {
            std::cout << nBlue << "\n";
            return 0;
        }
    }
}
