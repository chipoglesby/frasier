#!/bin/bash

for filename in ../scripts/*.txt; do
  result=$(grep -n "Transcript {[A-z]" "$filename" |cut -f1 -d:)
  tail -n +"$result" "$filename" | sed 's/[A-z]*:/!&/g; s/^ \{1,\}/!/g; s/^[^!*]*//; s/!\{1,\}//g; s/\[.*\]//g' | tr '\n' ' ' | sed 's/[A-z]*:/\
&/g' | sed 's/ \{2,\}/ /g' | sed "s/\"/'/g" | sed 's/.*/\"&\"/' >> ../data/lines.csv
done


