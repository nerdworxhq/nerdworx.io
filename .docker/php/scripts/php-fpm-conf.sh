#update fpm conf with our values
sed -i \
  -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" \
  -e "s/pm.max_children = 5/pm.max_children = 4/g" \
  -e "s/pm.start_servers = 2/pm.start_servers = 3/g" \
  -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" \
  -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" \
  -e "s/;pm.max_requests = 500/pm.max_requests = 200/g" \
  -e "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g" \
/usr/local/etc/php-fpm.d/www.conf