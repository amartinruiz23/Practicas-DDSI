#!/usr/bin/python


import Tkinter as tk
import sys

def user_reg():
     sys.argv = ["./user_reg.sh", sys.argv[1], sys.argv[2], sys.argv[3]]
     execfile("./user_reg.sh")

def comment_reg():
     sys.argv = ["./comentar.sh", sys.argv[1], sys.argv[2]]
     execfile("./comentar.sh")
     
root = tk.Tk()
root.geometry('500x500')
b = tk.Button(root, text="Registro de usuarios", command=user_reg).place(x=100, y=200)

s = tk.Button(root, text="Formulario de comentario", command=comment_reg).place(x=100, y=400)


root.mainloop()
