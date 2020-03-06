PHPVER=$1;

re='^[0-9]+([.][0-9]+)?$'
if ! [[ "$PHPVER" =~ $re ]] ; then
   echo "Usage ./$0 PHP_VERSION" >&2; exit 1
fi

sudo update-alternatives --set php /usr/bin/php$PHPVER;
sudo update-alternatives --set phar /usr/bin/phar$PHPVER;
sudo update-alternatives --set phar.phar /usr/bin/phar.phar$PHPVER;
sudo update-alternatives --set phpize /usr/bin/phpize$PHPVER;
sudo update-alternatives --set php-config /usr/bin/php-config$PHPVER;