#!/bin/bash

DB=$1
PREFIX=$2;

if [ -z "$DB" ] || [ -z "$PREFIX" ]; then
  echo "Usage ./$0 DB PREFIX" >&2; exit 1
fi

re='^[A-Za-z][A-Za-z0-9_]*$'
if ! [[ "$PREFIX" =~ $re ]] || ! [[ "$DB" =~ $re ]]; then
   echo "Invalid database name or table prefix" >&2; exit 1
fi

mysqldump DBNAME $(mysql -D $DB -Bse "show tables like '$PREFIX%'")
