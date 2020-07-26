#!/bin/bash

FILE=$0

if [ ! -f "$FILE" ] ; then
   echo "Usage ./$0 FILE" >&2; exit 1
fi

mv "$FILE" "$FILE.bak"
iconv -f UTF-16LE -t UTF-8 "$FILE.bak" > "$FILE"