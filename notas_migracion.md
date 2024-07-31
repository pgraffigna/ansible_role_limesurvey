### deteniendo apache
```shell
systemctl stop apache2.service
```

### backup de la db
```shell
mysqldump --quick --extended-insert --skip-comments -u lime_user -p lime_db | gzip -9 > ~/lime_db_$(date "+%y%m%d").sql.gz
```

### backup webroot
```shell
cp -ra /var/www/html/limesurvey/ ~/limesurvey_backup_$(date "+%y%m%d")
```

### descargar nueva version limesurvey
```shell
wget -q --show-progress --progress=bar:force 2>&1 https://download.limesurvey.org/latest-master/limesurvey6.6.0+240729.zip
```

### descomprimiendo + copiando nueva version
```shell
unzip lime.zip
chown -R www-data:www-data limesurvey
cp -pr limesurvey /var/www/html/
```

### copiando archivos de upload en nueva instalación
```shell
cp -pr limesurvey_backup_240730/upload/* /var/www/html/limesurvey/upload/
```

### reiniciando apache
```shell
systemctl restart apache2.service
```
