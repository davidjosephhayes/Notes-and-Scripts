CURRENT_REPO_URL=$1
NEW_REPO_URL=$2

if [ -z "$CURRENT_REPO_URL" ] || [ -z "$NEW_REPO_URL" ]; then
  echo "Usage ./$0 CURRENT_REPO_URL NEW_REPO_URL" >&2; exit 1
fi

PWD=$(pwd)
TMP=$(mktemp -d)

cd $TMP

git clone --mirror $CURRENT_REPO_URL .
git push --mirror $NEW_REPO_URL

cd $PWD

rm -rf $TMP
