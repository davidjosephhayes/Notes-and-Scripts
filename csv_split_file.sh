#!/bin/bash

# https://stackoverflow.com/questions/1411713/how-to-split-a-file-and-keep-the-first-line-in-each-of-the-pieces#1412058

FILE=$1
LINES=$2

if [ -z "$FILE" ] || [ -z "$LINES" ]; then
  echo "Usage ./$0 FILE LINES" >&2; exit 1
fi

if [ ! -f "$FILE" ] ; then
   echo "$FILE does not exist" >&2; exit 1
fi

re='^[0-9]+$'
if ! [[ "$LINES" =~ $re ]]; then
   echo "$LINES must be a positive integer" >&2; exit 1
fi

FILE="$(realpath $FILE)"
filename=$(basename -- "$FILE")
extension="${filename##*.}"
filename="${filename%.*}"

cd "$(dirname $FILE)"

tail -n +2 "$FILE" | split -l "$LINES" - split_
for subfile in split_*
do
    head -n 1 "$FILE" > tmp_file
    cat "$subfile" >> tmp_file
    mv -f tmp_file "$filename-$subfile.$extension"
    rm $subfile
done