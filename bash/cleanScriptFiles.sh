#!/bin/bash

for filename in ../data/scripts/*.txt; do
  result=$(grep -n "Transcript {[A-z]" "$filename" |cut -f1 -d:)
  seasonShow=$(echo "${filename##*/}" | sed "s/.txt//g")
  tail -n +"$result" "$filename" | sed 's/[A-z]*:/!&/g; s/^ \{1,\}/!/g; s/^[^!*]*//; s/!\{1,\}//g; s/\[.*\]//g' | tr '\n' ' ' | sed 's/[A-z]*:/\
&/g' | sed 's/ \{2,\}/ /g' | sed "s/\"/'/g" | sed 's/.*/\"&\"/' | sed "s/.*/&\,\"$seasonShow\"/" >> ../data/csv/lines.csv
done
