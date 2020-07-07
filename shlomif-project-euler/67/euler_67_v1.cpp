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

#include <iostream>
#include <fstream>
#include <sstream>
#include <algorithm>

#include <vector>
#include <stdio.h>

int main(int argc, char * argv[])
{
    FILE * in = fopen(argv[1], "r");

    char buffer[100000];

    int row = 1;
    std::vector< std::vector<long> > lines;
    while (fgets(buffer, sizeof(buffer)-1, in))
    {
        buffer[sizeof(buffer)-1] = '\0';
        std::stringstream ss;
        ss << buffer;
        std::vector<long> r;
        for (int col=0; col < row; col++)
        {
            long l;
            ss >> l;
            r.push_back(l);
        }
        lines.push_back(r);
        row++;
    }
    fclose(in);

    std::vector< std::vector<long> > total_lines;
    total_lines.push_back(lines[0]);

    for (int r = 1; r < lines.size() ; r++)
    {
        std::vector<long> last = total_lines.back();
        std::vector<long> this_ = lines[r];
        std::vector<long> new_;

        for (int i_ = 0; i_ < this_.size() ; i_++)
        {

            new_.push_back(this_[i_]
                + (
                    (i_ == 0) ? last[i_]
                    : (i_ == this_.size()-1) ? last[i_-1]
                    : std::max(last[i_-1] , last[i_])
                )
            );
        }
        total_lines.push_back(new_);
    }

    std::vector<long> last = total_lines.back();
    long max_ = last[0];

    for (int i_ = 1; i_ < last.size() ; i_++)
    {
        max_ = std::max(max_, last[i_]);
    }

    std::cout << "Max is " << max_ << std::endl;
}
