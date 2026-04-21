#opcache config
 echo "[opcache]" >> $PHP_INI_DIR/conf.d/opcache.ini 
 echo "opcache.enable=1" >> $PHP_INI_DIR/conf.d/opcache.ini 
 echo "opcache.memory_consumption=128" >> $PHP_INI_DIR/conf.d/opcache.ini 
 echo "opcache.max_accelerated_files=4000" >> $PHP_INI_DIR/conf.d/opcache.ini 
 echo "opcache_revalidate_freq=240" >> $PHP_INI_DIR/conf.d/opcache.ini 
 echo "opcache.validate_timestamps=0" >> $PHP_INI_DIR/conf.d/opcache.ini 
 echo "opcache.max_wasted_percentage=10" >> $PHP_INI_DIR/conf.d/opcache.ini 
 echo "opcache.interned_strings_buffer=16" >> $PHP_INI_DIR/conf.d/opcache.ini 
 echo "opcache.fast_shutdown=1" >> $PHP_INI_DIR/conf.d/opcache.ini 