# Magento 2 Defaults come with htaccess options that are not compatible with Virtualmin default install.
# Run the Following after install
find . -name .htaccess -exec sed -i 's/FollowSymLinks/SymLinksIfOwnerMatch/g' {} \;
find . -name .htaccess -exec sed -i 's/Options All -Indexes/Options -Indexes/g' {} \;