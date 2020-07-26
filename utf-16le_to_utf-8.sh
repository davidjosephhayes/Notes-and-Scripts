#!/bin/bash

# Generate Scripts to SQL out of SQL Server comes out in UTF-16 by default
# You can pick out UTF-16LE files by a BOM at the beginning of the file FE FF
# also, there will be a null 00 after evry ASCII character

FILE=$0

if [ ! -f "$FILE" ] ; then
   echo "Usage ./$0 FILE" >&2; exit 1
fi

mv "$FILE" "$FILE.bak"
iconv -f UTF-16LE -t UTF-8 "$FILE.bak" > "$FILE"