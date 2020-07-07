# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php
TARGETS := mini_factor-debug.exe mini_factor-prod.exe

all: $(TARGETS)

GCC_FLAGS = -Wall -Wextra -std=gnu++11

mini_factor-debug.exe: mini_factor.cpp
	g++ $(GCC_FLAGS) -g -o $@ $< -lm

mini_factor-prod.exe: mini_factor.cpp
	g++ $(GCC_FLAGS) -O3 -flto -fwhole-program -fvisibility=hidden -fomit-frame-pointer -march=native -o $@ $< -lm

test: all
	prove t/*.t

clean:
	rm -f $(TARGETS)
