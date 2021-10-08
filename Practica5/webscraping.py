#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup 
import os

print(" === Fotos de perritos === \n")
path = input("Ingrese el path absoluto donde guardara las imagenes: \t")

def make_dir():
  try:
    os.makedirs(path)
  except:
    os.chdir(path)

def fotos_perritos(fotos):
  i=0
  for foto in fotos:
    urlfoto = foto.get("src")
    #print(urlfoto)
    img = requests.get('http://animalesextremos.com/'+urlfoto)
    i+=1
    nombrefoto = 'Perrito'+str(i)+'.jpg'
    with open (nombrefoto, 'wb') as nombre:
      nombre.write(img.content)

  print("Disfruta tus fotos de perritos uwu")

make_dir()

url = ('https://www.animalesextremos.com/galerias-las-razas-de-perros-mas-populares')
r = requests.get(url)
html = r.content
soup = BeautifulSoup(html, "html.parser")
fotos = soup.find_all("img")

fotos_perritos(fotos)
