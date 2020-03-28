# UNTESTED
# https://gist.github.com/jmervine/e4c9af3adb14b78856cc

PB7_FILE=$1;

if [ ! -f "$PB7_FILE" ] ; then
   echo "Usage ./$0 PB7_FILE" >&2; exit 1
fi

PACKAGE="openssl"
if ! dpkg -l | grep -q "$PACKAGE"; then
  sudo apt install "$PACKAGE"
fi

openssl pkcs7 -print_certs -in "$PB7_FILE" -out "$PB7_FILE.crt"
