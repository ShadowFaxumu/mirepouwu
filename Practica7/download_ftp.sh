#!/bin/bash

trap ctrl_c INT

function ctrl_c() {
    echo -e "\n[!] Bye c:\n"
    tput cnorm; exit 1
}

descargando_archivos() {
    ftp -inv $1 <<EOF
    user $2 $3
    cd $carpeta
    mget "*.txt"
    bye
EOF
}

cd $4

carpetas=$(lftp -e "find -d 3; bye" $1)
numero_de_carpetas=`echo $carpetas | wc -w`

for i in $(seq $numero_de_carpetas)
do
    carpeta=$(echo $carpetas | cut -d' ' -f$i)
    descargando_archivos "$1" "$2" "$3" "$carpeta"
done
echo Sale bye c:💛
