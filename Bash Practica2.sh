#!/bin/bash 

myfunc() {

	echo "Soy un script y me llamo" $0 
	echo $1", este es un contador del 0 al 10"
}
saludo=$(myfunc Profesor)
echo $saludo

NUMERO=0

while [  $NUMERO -le 10 ]
    do
    echo $NUMERO
        let NUMERO+=1
    done
    if [[ $NUMERO=10 ]]
        then
            echo "Ha llegado hasta el número final"
        fi
        
