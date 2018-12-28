#!/usr/bin/python2.7
# encoding: utf-8

import Tkinter as tk
import sys
import subprocess

def user_reg():
     # sys.argv = ["./user_reg.sh", sys.argv[1], sys.argv[2], sys.argv[3]]
     # execfile("./user_reg.sh")
     subprocess.call([sys.executable, './user_reg.sh', sys.argv[1], sys.argv[2], sys.argv[3]])
     
def comment_reg():
     # sys.argv = ["./comentar.sh", sys.argv[1], sys.argv[2], sys.argv[3]]
     # execfile("./comentar.sh")  
     subprocess.call([sys.executable, './comentar.sh', sys.argv[1], sys.argv[2], sys.argv[3]])
     
def song_reg():
     # sys.argv = ["./añadir-cancion.sh", sys.argv[1], sys.argv[2], sys.argv[3]]
     # execfile("./añadir-cancion.sh")
     subprocess.call([sys.executable, './cancion.sh', sys.argv[1], sys.argv[2], sys.argv[3]])
     
def search():
     # sys.argv = ["./busqueda.sh", sys.argv[1], sys.argv[2], sys.argv[3]]
     # execfile("./busqueda.sh")
     subprocess.call([sys.executable, './busqueda.sh', sys.argv[1], sys.argv[2], sys.argv[3]])
     
root = tk.Tk()
root.geometry('500x500')
b = tk.Button(root, text="Registro de usuarios", command=user_reg).place(x=100, y=200)

s = tk.Button(root, text="Añadir un comentario", command=comment_reg).place(x=100, y=400)

j = tk.Button(root, text="Añadir una canción", command=song_reg).place(x=300, y=200)

a = tk.Button(root, text="Búsqueda", command=search).place(x=300, y=400)

root.mainloop()
