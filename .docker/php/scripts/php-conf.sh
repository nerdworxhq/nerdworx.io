#memory limits
echo "memory_limit=2048M" > $PHP_INI_DIR/conf.d/memory-limit.ini 
echo "max_execution_time=900" >> $PHP_INI_DIR/conf.d/memory-limit.ini 
echo "post_max_size=100M" >> $PHP_INI_DIR/conf.d/memory-limit.ini
echo "upload_max_filesize=100M" >> $PHP_INI_DIR/conf.d/memory-limit.ini
echo "zend.max_allowed_stack_size=33554432" >> $PHP_INI_DIR/conf.d/memory-limit.ini

#timezone setup
echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini 

#error outputs
echo "display_errors=stderr" > $PHP_INI_DIR/conf.d/display-errors.ini 

#path info fixes
echo "cgi.fix_pathinfo=0" > $PHP_INI_DIR/conf.d/path-info.ini 
echo "expose_php=0" > $PHP_INI_DIR/conf.d/path-info.ini 
