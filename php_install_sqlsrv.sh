# NOT STAND ALONE, JUST NOTES
# https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15
# https://docs.microsoft.com/en-us/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-ver15#installing-the-drivers-on-ubuntu-1604-1804-and-1910
# https://serverpilot.io/docs/how-to-install-the-php-sqlsrv-extension/
# run php_install_sqlsrv.sh $PHPVER first

PHPVER=$1;

re='^[0-9]+([.][0-9]+)?$'
if ! [[ "$PHPVER" =~ $re ]] ; then
   echo "Usage ./$0 PHP_VERSION" >&2; exit 1
fi

sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

#Download appropriate package for the OS version
#Choose only ONE of the following, corresponding to your OS version

#Ubuntu 16.04
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

#Ubuntu 18.04
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

#Ubuntu 19.10
curl https://packages.microsoft.com/config/ubuntu/19.10/prod.list > /etc/apt/sources.list.d/mssql-release.list

exit
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install msodbcsql17
# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
# optional: for unixODBC development headers
sudo apt-get install unixodbc-dev

# Install PECL packages
sudo pecl install sqlsrv # add a -f after install to force install these for different versions
sudo pecl install pdo_sqlsrv
sudo su
printf "; priority=20\nextension=sqlsrv.so\n" > "/etc/php/$PHPVER/mods-available/sqlsrv.ini"
printf "; priority=30\nextension=pdo_sqlsrv.so\n" > "/etc/php/$PHPVER/mods-available/pdo_sqlsrv.ini"
exit
sudo phpenmod -v "$PHPVER" sqlsrv pdo_sqlsrv