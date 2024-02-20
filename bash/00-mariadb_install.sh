#!/bin/bash

#colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

#Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${ROJO}[MARIA_DB] Programa Terminado por el usuario ${FIN}"
        exit 0
}

# variables
MYSQL_ROOT_PASSWORD="mysql_root_pass"
MYSQL_DB="lime_db"
MYSQL_USER="lime_user"
MYSQL_PASS="lime_pass"

echo -e "${AMARILLO}[MARIA_DB] Instalando mariadb ${FIN}\n"
sudo apt update && sudo apt install -y mariadb-server

echo -e "${AMARILLO}[MARIA_DB] Configurando mysql root password ${FIN}\n"
sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MYSQL_ROOT_PASS') WHERE User = 'root'"

echo -e "${AMARILLO}[MARIA_DB] Eliminando usuario anonimo ${FIN}\n"
sudo mysql -e "DROP USER IF EXISTS ''@'localhost'"

echo -e "${AMARILLO}[MARIA_DB] Fix para el localhost/hostname ${FIN}\n"
sudo mysql -e "DROP USER IF EXISTS ''@'$(hostname)'"

echo -e "${AMARILLO}[MARIA_DB] Eliminando la db test ${FIN}\n"
sudo mysql -e "DROP DATABASE IF EXISTS test"

echo -e "${AMARILLO}[MARIA_DB] Creando usuario + aplicando permisos sobre db ${FIN}"
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB"
sudo mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASS'"
sudo mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DB.* to '$MYSQL_USER'@'localhost'"

echo -e "\n${VERDE}[MARIA_DB] La db $MYSQL_DB fue creada con exito se le dio permisos de escritura al usuario $MYSQL_USER ${FIN}"
