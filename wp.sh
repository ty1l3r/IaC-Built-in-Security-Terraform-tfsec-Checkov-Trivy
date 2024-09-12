#!/bin/bash

# variables
DB_NAME="wordpress_db"            # Name of the database
DB_USER="fab"                     # Database username
DB_PASSWORD="Datascientest@2024"  # Database password

WORDPRESS_DIR="/var/www/html"     # wordpress code directory

# Update the system
sudo yum update -y

# Install Apache HTTP server, MariaDB, and PHP
sudo yum install -y httpd wget php-fpm php-mysqli php-json php php-devel
sudo yum install -y mariadb105-server

# Start Apache & Enable Apache to start on boot
sudo systemctl start httpd
sudo systemctl enable httpd
sudo usermod -a -G apache ec2-user

# Set correct permissions for Apache web directory
sudo chown -R ec2-user:apache /var/www/html/
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

# Create a PHP info page for testing
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

# ** Health Check Page **
echo "healthy" > /var/www/html/healthcheck.html  # Créer une page de health check

# Install required PHP modules
sudo yum install -y php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap}

# Start MariaDB & Enable MariaDB to start on boot
sudo systemctl enable --now mariadb

# Secure the MariaDB installation
sudo yum install expect -y

expect - <<EOF
spawn sudo mysql_secure_installation
expect "Enter current password for root (enter for none):"
send "\r"
expect "Switch to unix_socket authentication:"
send "n\r"
expect "Change the root password?"
send "y\r"
expect "New password:"
send "$DB_PASSWORD\r"
expect "Re-enter new password:"
send "$DB_PASSWORD\r"
expect "Remove anonymous users?"
send "y\r"
expect "Disallow root login remotely?"
send "y\r"
expect "Remove test database and access to it?"
send "y\r"
expect "Reload privilege tables now?"
send "y\r"
expect eof
EOF

# Download and install WordPress
cd /home/ec2-user
wget https://wordpress.org/latest.zip
unzip latest.zip

# Move WordPress files to Apache's web directory
mv wordpress/* ${WORDPRESS_DIR}
sudo chown -R ec2-user:apache ${WORDPRESS_DIR}

# Create the WordPress database and user
mysql -u root -e "CREATE DATABASE $DB_NAME;"
mysql -u root -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Configure WordPress settings
cd ${WORDPRESS_DIR}
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
sed -i "s/localhost/localhost/" wp-config.php

# Set appropriate permissions for the WordPress directory
sudo find ${WORDPRESS_DIR} -type d -exec chmod 755 {} \;
sudo find ${WORDPRESS_DIR} -type f -exec chmod 644 {} \;

# Restart Apache to apply changes
sudo systemctl restart httpd

echo "**************************************************************************************"
echo "******** Datascientest Wordpress installation  has been executed successfully ********"
echo "**************************************************************************************"
