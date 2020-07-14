#!/bin/bash

DB=$1
USER=$2
PREFIX=$3

if [ -z "$DB" ] || [ -z "$USER" ] || [ -z "$PREFIX" ]; then
  echo "Usage ./$0 DB USER PREFIX" >&2; exit 1
fi

re='^[A-Za-z][A-Za-z0-9_]*$'
if ! [[ "$PREFIX" =~ $re ]] || ! [[ "$USER" =~ $re ]] || ! [[ "$DB" =~ $re ]]; then
   echo "Invalid database name, user, or table prefix" >&2; exit 1
fi

mysqldump -u $USER -p DBNAME $(mysql -D $DB -u $USER -p -Bse "show tables like '$PREFIX%'")
