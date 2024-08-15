# Use an official PHP-FPM image
FROM php:8.1-fpm

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm /etc/nginx/sites-enabled/default

# Copy your custom Nginx configuration file
COPY nginx.conf /etc/nginx/sites-enabled/default

# Copy your application files to the container
COPY . /var/www/html/

# Set the working directory
WORKDIR /var/www/html/

# Ensure proper permissions for the web server
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 80 for the web server
EXPOSE 80

# Start both Nginx and PHP-FPM
CMD service nginx start && php-fpm
