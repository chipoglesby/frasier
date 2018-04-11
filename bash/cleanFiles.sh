#!/bin/bash

grep -n "Transcript {[a-z]" 0102.txt

tail -n +53 0101.txt | sed 's/[A-Za-z]*:/!&/g; s/^ \{1,\}/!/g; s/^[^!*]*//; s/!\{1,\}//g' | tr '\n' ' ' | sed 's/[A-Za-z]*:/\
&/g' | sed 's/ \{2,\}/ /g' | sed "s/\"/'/g" | sed 's/.*/\"&\"/' > test.csv
