rm -f ./config.safe.env
repo-refresh
php artisan key:generate --force
