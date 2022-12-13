#!/bin/bash

#colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

#Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${ROJO}[LIMESURVEY] Programa Terminado por el usuario ${FIN}"
        exit 0
}

# variables
LIME_URL="https://download.limesurvey.org/latest-stable-release/limesurvey5.4.15+221212.zip"
LIME_TMP="/tmp/limesurvey-5.4.15.zip"
LIME_CONFIG="limesurvey.conf"
#SERVER_NAME="encuestas.cultura.lab"

echo -e "${AMARILLO}[LIMESURVEY] Instalando apache + php ${FIN}\n"
sudo apt update && sudo apt -y install apache2 php libapache2-mod-php php-{mysql,mbstring,xml,zip,imap,gd,ldap} unzip

echo -e "${AMARILLO}[LIMESURVEY] Descargando limesurvey ${FIN}\n"
wget -q --show-progress --progress=bar:force 2>&1 "$LIME_URL" -O "$LIME_TMP"

echo -e "${AMARILLO}[LIMESURVEY] Descomprimiendo limesurvey ${FIN}\n"
sudo unzip "$LIME_TMP" -d /var/www/html

echo -e "${AMARILLO}[LIMESURVEY] Cambiando los permisos ${FIN}\n"
sudo chown www-data:www-data -R /var/www/html/limesurvey/ && sudo chmod 755 -R /var/www/html/limesurvey/

echo -e "${AMARILLO}[LIMESURVEY] Configurando sitio ${FIN}\n"
sudo tee /etc/apache2/sites-available/${LIME_CONFIG} >/dev/null <<EOF
<VirtualHost *:80>
        ServerAdmin administradores@cultura.lab
        DocumentRoot /var/www/html/limesurvey
        ServerName encuestas.cultura.lab

        <Directory /var/www/html/limesurvey>
                Options FollowSymlinks
                AllowOverride All
                Require all granted
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/encuestas.cultura.lab_error.log
        CustomLog ${APACHE_LOG_DIR}/encuestas.cultura.lab_access.log combined
</VirtualHost>
EOF

echo -e "${AMARILLO}[LIMESURVEY] Activando sitio y modulos ${FIN}\n"
sudo a2ensite limesurvey && sudo a2enmod rewrite

echo -e "${AMARILLO}[LIMESURVEY] Reiniciando servicios ${FIN}\n"
sudo systemctl restart apache2

echo -e "${VERDE}[LIMESURVEY] Accede a http://$(hostname -I | sed s/' '/''/g)/limesurvey para continuar con la configuración ${FIN}" 

