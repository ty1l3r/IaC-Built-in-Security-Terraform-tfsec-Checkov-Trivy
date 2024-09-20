#!/bin/bash

# variables
DB_NAME="fabienDatabase"            # Name of the database
DB_USER="${db_username}"                    # Database username
DB_PASSWORD="${db_password}"           # Database password
WORDPRESS_DIR="/var/www/html"       # WordPress code directory
RDS_ENDPOINT="${rds_endpoint}"       # Directly use the endpoint with port

# Echo the RDS endpoint for debugging
echo "RDS Endpoint: $RDS_ENDPOINT"

# Update the system
sudo yum update -y

# Enable and install PHP 7.4
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum install -y php php-cli php-fpm php-json php-mbstring php-xml php-mysqlnd php-common php-zip php-curl

# Install Apache HTTP server
sudo yum install -y httpd wget

# Start Apache & Enable Apache to start on boot
sudo systemctl start httpd
sudo systemctl enable httpd
sudo usermod -a -G apache ec2-user

# Verify that Apache is running
sudo systemctl status httpd

# Set correct permissions for Apache web directory
sudo chown -R ec2-user:apache /var/www/html/
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

# Create a PHP info page for testing
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

# ** Health Check Page **
echo "healthy" > /var/www/html/healthcheck.html  # Create a health check page

# Install MySQL client for interacting with the RDS database
sudo yum install -y mysql

# Create the WordPress database and user on RDS
mysql -h "$RDS_ENDPOINT" -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;" || { echo "Database creation failed"; exit 1; }
mysql -h "$RDS_ENDPOINT" -u "$DB_USER" -p"$DB_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';" || { echo "Granting privileges failed"; exit 1; }
mysql -h "$RDS_ENDPOINT" -u "$DB_USER" -p"$DB_PASSWORD" -e "FLUSH PRIVILEGES;" || { echo "Flushing privileges failed"; exit 1; }

# Download and install WordPress only if not already installed
if [ ! -d "$WORDPRESS_DIR/wp-admin" ]; then
  cd /home/ec2-user
  wget https://wordpress.org/latest.zip
  unzip latest.zip
  mv wordpress/* ${WORDPRESS_DIR}
  sudo chown -R ec2-user:apache ${WORDPRESS_DIR}
else
  echo "WordPress is already installed"
fi

# Configure WordPress settings
cd ${WORDPRESS_DIR}
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
# Replace localhost with the RDS endpoint
sed -i "s/localhost/$RDS_ENDPOINT/" wp-config.php

# Set appropriate permissions for the WordPress directory
sudo find ${WORDPRESS_DIR} -type d -exec chmod 755 {} \;
sudo find ${WORDPRESS_DIR} -type f -exec chmod 644 {} \;

# Restart Apache to apply changes
sudo systemctl restart httpd

# Copy the private key to the EC2 instance's home directory
sudo cp /home/ubuntu/project/key_rsa /home/ec2-user/key_rsa

# Ensure correct permissions for the private key (only readable by the owner)
sudo chmod 600 /home/ec2-user/key_rsa

echo "**************************************************************************************"
echo "******** Datascientest WordPress installation has been executed successfully ********"
echo "**************************************************************************************"
