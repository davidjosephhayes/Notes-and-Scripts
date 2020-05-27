PHPVER=$1;

re='^[0-9]+([.][0-9]+)?$'
if ! [[ "$PHPVER" =~ $re ]] ; then
   echo "Usage ./$0 PHP_VERSION" >&2; exit 1
fi

PHPAPI=`php -i | grep 'PHP API' | sed -e 's/PHP API => //'`;

# https://stackoverflow.com/questions/19561722/pecl-installs-for-previous-php-version

if [ -x "$(command -v pecl)" ]; then
   sudo pecl config-set ext_dir /usr/lib/php/$PHPAPI
   sudo pecl config-set php_bin /usr/bin/php$PHPVER
   sudo pecl config-set php_ini /etc/php/$PHPVER/cli/php.ini
   sudo pecl config-set php_suffix $PHPVER
fi

if [ -x "$(command -v pear)" ]; then
   sudo pear config-set ext_dir /usr/lib/php/$PHPAPI
   sudo pear config-set php_bin /usr/bin/php$PHPVER
   sudo pear config-set php_ini /etc/php/$PHPVER/cli/php.ini
   sudo pear config-set php_suffix $PHPVER
fi

sudo update-alternatives --set php /usr/bin/php$PHPVER;
sudo update-alternatives --set phar /usr/bin/phar$PHPVER;
sudo update-alternatives --set phar.phar /usr/bin/phar.phar$PHPVER;
sudo update-alternatives --set phpize /usr/bin/phpize$PHPVER;
sudo update-alternatives --set php-config /usr/bin/php-config$PHPVER;