PHPVER=$1;

re='^[0-9]+([.][0-9]+)?$'
if ! [[ "$PHPVER" =~ $re ]] ; then
   echo "Usage ./$0 PHP_VERSION" >&2; exit 1
fi

# install required packages
PACKAGE="software-properties-common"
if ! dpkg -l | grep -q "$PACKAGE"; then
  sudo apt install "$PACKAGE"
fi

# add php repo if necessary
PPA="ondrej/php"
if ! grep -q "^deb .*$PPA" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository "ppa:$PPA"
fi

sudo apt update
sudo apt install -y \
  php$PHPVER \
  php$PHPVER-bcmath \
  php$PHPVER-bz2 \
  php$PHPVER-cgi \
  php$PHPVER-cli \
  php$PHPVER-common \
  php$PHPVER-curl \
  php$PHPVER-dev \
  php$PHPVER-gd \
  php-imagick \
  php$PHPVER-imap \
  php$PHPVER-intl \
  php$PHPVER-json \
  php$PHPVER-ldap \
  php$PHPVER-mbstring \
  php$PHPVER-mysql \
  php$PHPVER-opcache \
  php$PHPVER-readline \
  php$PHPVER-soap \
  php$PHPVER-xml \
  php$PHPVER-xsl \
  php$PHPVER-zip