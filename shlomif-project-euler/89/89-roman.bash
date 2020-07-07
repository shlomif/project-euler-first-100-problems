#!/bin/bash

# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

count()
{
    perl -0777 -ln -E '$count = tr/[A-Z]//d; say $count'
}

input()
{
    cat "../roman.txt"
}

(
    (input |
    perl -pe '
        s/^(M*)/$1,/;
        s/,(CM|DCCCC)/CM,/;
        s/,(CD|CCCC)/CD,/;
        s/,(D)/D,/;
        s/,(C{0,3})/$1,/;
        s/,(XC)/$1,/;
        s/,(XL)/$1,/;
        s/,L/L,/;
        s/,XXXX/XL,/;
        s/LXL,/XC,/;
        s/,(X{0,3})/$1,/;
        s/,(IX)/$1,/;
        s/,VIIII/IX,/;
        s/,IIII/,IV/;
        s/,IV/IV,/;
        s/,V/V,/;
        s/VIV,/IX,/;
        s/,(I{0,3})/$1,/;
        s/,$//;
    ' | count
    )
    (input | count )
) | \
    (read AFTER ; read BEFORE ; echo $((BEFORE - AFTER)))
