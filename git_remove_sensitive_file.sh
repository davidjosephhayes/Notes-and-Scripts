# https://help.github.com/en/github/authenticating-to-github/removing-sensitive-data-from-a-repository

FILE_TO_PURGE=$1;

if [ ! -f "$FILE_TO_PURGE" ] ; then
   echo "Usage ./$0 FILE_TO_PURGE" >&2; exit 1
fi

git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch ""$FILE_TO_PURGE""" \
  --prune-empty --tag-name-filter cat -- --all;
git push --force;