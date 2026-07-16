curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp


crontab -u eureka -e


5 * * * * /usr/local/bin/wp --path=/home/eureka/wp6 cron event run --due-now >> /home/eureka/wp-cron.log 2>&1
