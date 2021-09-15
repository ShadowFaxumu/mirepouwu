#!/bin/bash

usergit=(s4yago ShadowFaxumu LuisValdezHdz ppgodel)

#funcion para obtener los repos de los nombres dados en el array
function get_repos() {

  for u in "${usergit[@]}"
    do
      repos=`curl -s  "https://api.github.com/users/$u/repos" | jq -j '.[] | .name, " // "'`
      
      echo -e "\nNombre de los repos de $u: $repos"
    done

}

#funcion para extraer los que hicieron cambios al repo
function get_contributors(){

  curl -s "https://api.github.com/repos/$user/$repositorio/contributors" | jq -j '.[] | .login, "\n"'

}

#aqui empieza el codigo
echo "=== Nombres de los repositorios de mis amigos ==="

get_repos

echo -e "\n=== Para ver los colaboradores de los repositorios ==="
echo -e "\n Introduce el usuario: " 
read user
echo "Introduce el nombre del repositorio"
read repositorio


echo -e "\n Estos son los colaboradores: "
get_contributors

