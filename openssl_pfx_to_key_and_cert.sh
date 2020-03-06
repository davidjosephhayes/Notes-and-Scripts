# https://www.markbrilman.nl/2011/08/howto-convert-a-pfx-to-a-seperate-key-crt-file/
# https://stackoverflow.com/questions/27497723/export-a-pkcs12-file-without-an-export-password

PFX_FILE=$1;
OUTPUT=$2;

if [ ! -f "$PFX_FILE" ] ; then
   echo "Usage ./$0 PFX_FILE" >&2; exit 1
fi

PACKAGE="openssl"
if ! dpkg -l | grep -q "$PACKAGE"; then
  sudo apt install "$PACKAGE"
fi

openssl pkcs12 -in "$PFX_FILE" -nocerts -out "$PFX_FILE.pem"
openssl rsa -in "$PFX_FILE.pem" -out "$PFX_FILE.key"
openssl pkcs12 -in "$PFX_FILE" -nodes -nokeys -cacerts -out "$PFX_FILE.ca"
openssl pkcs12 -in "$PFX_FILE" -clcerts -nokeys -out "$PFX_FILE.cert"